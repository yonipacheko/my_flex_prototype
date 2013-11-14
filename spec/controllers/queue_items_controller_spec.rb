require 'spec_helper'


describe QueueItemsController do
  describe 'GET index' do
    it 'sets @queue_items to queue items of the logged in user' do

      carol = Fabricate(:user)
      session[:user_id] = carol.id
      queue_item1 = Fabricate(:queue_item, user: carol)
      queue_item2 = Fabricate(:queue_item, user: carol)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it 'redirects  to the sign_in page for unauthenticated users' do
      get :index
      expect(response). to redirect_to(sign_in_path)
    end
  end

  describe 'POST create' do
    it 'redirects to my queue-page' do
      user = Fabricate(:user)
      session[:user_id] = user.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end
    it 'creates a queue_item' do
      user = Fabricate(:user)
      session[:user_id] = user.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)

    end

    it 'creates the queue item that is associated with the video' do
      user = Fabricate(:user)
      session[:user_id] = user.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video). to eq(video)
    end
    it 'creates the queue item that is associated with the sign_in user' do
      user = Fabricate(:user)
      session[:user_id] = user.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(user)

    end
    it ' pus the video in the last place in the queue' do
      carol = Fabricate(:user)
      session[:user_id] = carol.id
      futurama = Fabricate(:video)
      Fabricate(:queue_item, video: futurama, user: carol) #first item built!
      monk = Fabricate(:video)
      post :create, video_id: monk.id # we build the second item heating the DB

      fururama_queue_item = QueueItem.where(video_id: monk.id, user_id: carol.id).first
      expect(fururama_queue_item.position).to eq(2)
    end

    it ' doesnt put video in the queue if video is already in the queue' do
      carol = Fabricate(:user)
      session[:user_id] = carol.id
      futurama = Fabricate(:video)
      Fabricate(:queue_item, video: futurama, user: carol) #first item built!
      post :create, video_id: futurama.id # we build the second item heating the DB
      expect(carol.queue_items.count).to eq(1)

    end
    it ' redirects user to sign_in if user is not authenticated' do
      futurama = Fabricate(:video)
      post :create, video_id: futurama.id # we build the second item heating the DB

      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'DELETE destroy' do
    it 'redirect to my queue page' do
      session[:user_id] = Fabricate(:user).id
      queue_item = Fabricate(:queue_item)

      delete :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path
    end
    it 'deletes the queue item' do

      user = Fabricate(:user)
      session[:user_id] = user.id
      queue_item = Fabricate(:queue_item, user: user)    # creating an item
      delete :destroy, id: queue_item.id     # passing data (queue_item-obj) to destroy action
      expect(QueueItem.count).to eq(0)
    end

    it ' it doesnt delete the queue-item that doesnt own the current user' do
      carol = Fabricate(:user)
      session[:user_id] = carol.id
      another_user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: another_user)    # creating an item, heating the DB
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)      #this item would never be destroy >> our statement

    end

    it 'redirects to the sign_in_page for unauthenticated user' do
      queue_item = Fabricate(:queue_item)    # creating an item, heating the DB
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to sign_in_path
    end

    it ' normalizes the the remaining queue items' do
      hello = Fabricate(:user)
      session[:user_id] = hello
      video = Fabricate(:video)
      queue_item1 = Fabricate(:queue_item, user: hello, video: video, position: 1)
      queue_item2 = Fabricate(:queue_item, user: hello, video: video, position: 2)
      delete :destroy, id: queue_item1.id
      expect(QueueItem.count).to eq(1)
    end
  end

  describe 'POST update queue' do
    context 'with valid inputs'
      let(:kitty){ Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: kitty,  video: video, position: 1) }
      let(:queue_item2) { Fabricate(:queue_item, user: kitty,  video: video, position: 2) }

      before do
        session[:user_id] = kitty.id
      end


      it 'redirects to my queue page' do

        post :update_queue, queue_items: [{ id: queue_item1.id, position: 2},{ id: queue_item2, position: 1}]
        expect(response).to redirect_to my_queue_path

      end

      it 'reorders the queue items' do

        post :update_queue, queue_items: [{ id: queue_item1.id, position: 2},{ id: queue_item2.id, position: 1}]
        expect(kitty.queue_items).to eq([queue_item2, queue_item1])
      end


      it 'normalizes the position numbers' do

        post :update_queue, queue_items: [{ id: queue_item1.id, position: 2},{ id: queue_item2, position: 1}]
        expect(kitty.queue_items.map(&:position)).to eq([1, 2])
      end
    context 'with invalid inputs' do
      it 'redirects to my_queue_page' do

        post :update_queue, queue_items: [{ id: queue_item1.id, position: 2},{id: queue_item2, position: 1}]
        expect(response).to redirect_to my_queue_path
      end
      it 'doesnt not change the queue items' do

        post :update_queue, queue_items: [{ id: queue_item1.id, position: 2},{id: queue_item2, position: 1.5}]
        expect(queue_item1.reload.position).to eq(1)
      end

      it 'sets  the flash error message' do

        post :update_queue, queue_items: [{ id: queue_item1.id, position: 2},{id: queue_item2, position: 1.5}]
        expect(flash[:error]).to be_present

      end

    end

    context 'with authenticated users'
    context 'with the queue items that don not belong to the current user'
  end
end
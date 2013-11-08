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

    it 'creates the queuue item that is associated with the video' do
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
    it ' pus the video in the last place in the queuue' do
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
end
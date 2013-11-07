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
end
require 'spec_helper'
require 'pry'

describe VideosController do


  it 'sets @video ' do
    session[:user_id] = Fabricate(:user).id
    video = Fabricate(:video)
    get :show, id: video.id
    expect(assigns(:video)).to eq(video)
  end

  it 'sets @reviews for authenticated users' do
    session[:user_id] = Fabricate(:user).id
    video = Fabricate(:video)
    review1 = Fabricate(:review, video: video)
    review2  = Fabricate(:review, video: video)
    get :show, id: video.id
    expect(assigns(:reviews)).to match_array([review1, review2])
  end
  context 'with unauthenticated users, testing if :require_user (before_filter) works' do
    it 'redirects the user to the sign_in page' do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end

  describe 'POST search'
    it 'sets @results  for authenticated user' do
      session[:user_id] = Fabricate(:user).id
      futurama = Fabricate(:video, title: 'Futurama')
      #binding.pry
      post :search, search_term: 'rama'
      expect(assigns(:results)).to eq([futurama])

    end
  end
end
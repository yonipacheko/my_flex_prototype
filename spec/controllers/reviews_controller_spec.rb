require 'spec_helper'

describe ReviewsController do
  describe 'POST create' do
    context 'with authenticated users' do
      context 'with valid users' do
        context 'with valid inputs' do

        end
        context ' with invalid inputs' do
          it 'create a review' do
            post :create, Fabricate.attributes_for(:review), Fabricate(:video).id
          end
          it 'creates a review associated with  the video'
          it 'creates a review associated with signed_in_user'
          it 'redirects the video to the show page'

        end
      end
      context 'with unauthenticated users ' do

      end
    end
  end
end
require 'spec_helper'

describe PasswordResetsController do
  describe 'GET show' do
   it 'renders show template if the token is valid' do
     kitty = Fabricate(:user)
     # we do this cuz our before_action is updating our token automatically
     #this way we get control over it
     kitty.update_column(:token, '1234')
     get :show, id: '1234'
     expect(response).to render_template :show
   end

   it 'sets @token' do
     kitty = Fabricate(:user)
     kitty.update_column(:token, '1234')
     get :show, id: '1234'
     expect(assigns(:token)).to eq(kitty.token)
   end

   it 'redirects to the expired token page if the token is not valid' do
     get :show, id: '1234'
     expect(response).to redirect_to expired_token_path
   end
 end
  describe 'POST create' do
    context 'with valid token' do
      it 'redirect to sign_in page' do
        kitty = Fabricate(:user, password: 'old_password')
        kitty.update_column(:token, '1234')
        post :create, token: '1234', password: 'new_password'
        expect(response).to redirect_to sign_in_path
      end
      it 'updates the users password' do
        kitty = Fabricate(:user, password: 'old_password')
        kitty.update_column(:token, '1234')
        post :create, token: '1234', password: 'new_password'
        # we need to heat the DB with reload
        expect(kitty.reload.authenticate('new_password')).to be_true

      end
      it 'sets the flash success message' do
        kitty = Fabricate(:user, password: 'old_password')
        kitty.update_column(:token, '1234')
        post :create, token: '1234', password: 'new_password'
        # we need to heat the DB with reload
        expect(flash[:success]).to be_present
      end
      it 'regenerates the user token' do
        kitty = Fabricate(:user, password: 'old_password')
        kitty.update_column(:token, '1234')
        post :create, token: '1234', password: 'new_password'
        expect(kitty.reload.token).not_to eq('1234')
      end
    end
    context 'with invalid token' do
      it 'redirects to the expired token path' do
        post :create, token: '1234', password: 'some_password'
        expect(response).to redirect_to expired_token_path
      end

    end
  end


end
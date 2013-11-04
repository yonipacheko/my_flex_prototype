require 'spec_helper'

describe SessionsController do
  describe 'GET new' do
    it 'renders the new template for authenticated users' do
      get :new
      expect(response).to render_template :new
    end
    it 'redirects to the home page for authenticated users' do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end

    describe 'POST creastes' do
      context 'with valid credentials' do
        it 'puts the sign_in user in the session' do
          carlos = Fabricate(:user)
          post :create, email: carlos.email, password: carlos.password, full_name: carlos.full_name
          expect(session[:user_id]).to eq(carlos.id)
        end
        it 'redirects to the home_page' do
          rafa = Fabricate(:user)
          post :create, email: rafa.email, password: rafa.password
          expect(response).to redirect_to home_path
        end
        it 'sets the notice' do
          rafa = Fabricate(:user)
          post :create, email: rafa.email, password: rafa.password
          expect(flash[:notice]).not_to be_blank
        end


      end

      context' with invalid credentials' do
        it' redirects to the sign_in page' do
          rafa = Fabricate(:user)
          post :create, email: rafa.email, password: rafa.password + 'ewrw'
          expect(response).to redirect_to sign_in_path
        end
        it 'doesnt put the sign_in user  in the session' do
          rafa = Fabricate(:user)
          post :create, email: rafa.email, password: rafa.password + 'ewrw'
          expect(session[:user_id]).to be_nil
        end

        it 'set the error message' do
          rafa = Fabricate(:user)
          post :create, email: rafa.email, password: rafa.password + 'ewrw'
          expect(flash[:error]).not_to be_blank
        end
      end

    end
  end
end

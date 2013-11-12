require 'spec_helper'
require 'pry'


describe UsersController do
  describe 'GET new' do
    it 'sets @user'  do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
  describe 'POST create' do
    context 'with valid input' do
      it 'creates the user' do
        user_obj = Fabricate(:user)
        #binding.pry
        post :create, user: { email: user_obj.email, password: user_obj.password, full_name: user_obj.full_name }

        expect(User.count).to eq(1)
      end
      it 'redirects to the sign in page ' do
        user_obj = Fabricate(:user)
       # post :create, user: { email: user_obj.email, password: user_obj.password, full_name: user_obj.full_name }
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to sign_in_path
      end
    end
    context 'with invalid input' do
      it 'doesnt create the user' do
        post :create, user: { password: 'ad', full_name: 'asd' }
        expect(User.count).to eq(0)
      end
      it 'render the :new template' do
        post :create, user: { password: 'ad', full_name: 'asd' }
       expect(response).to render_template :new
      end
      it ' set @user' do
        post :create, user: { email: 'dsf@sdf.com', password: 'ad', full_name: 'asd' }

        expect(assigns(:user)).to be_instance_of(User)
      end


    end
  end
end
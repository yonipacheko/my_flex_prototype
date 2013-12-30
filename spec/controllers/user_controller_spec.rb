require 'spec_helper'
require 'pry'


describe UsersController do

  before do
    StripeWrapper::Charge.stub(:create)
  end
  after { ActionMailer::Base.deliveries.clear }

  describe 'GET new' do
    it 'sets @user'  do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
  describe 'POST create' do

    context 'valid input' do

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
     #this one a tricky one
      it 'makes the user follow the invider' do
        kitty = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: kitty, recipient_email: 'ko@ko.com')
        post :create, user: {email: 'ly@ko.com', password: 'password', full_name: 'lykke li'}, invitation_token: invitation.token
        lykke = User.where(email: 'ly@ko.com').first
        expect(lykke.follows?(kitty)).to be_true
      end
      it 'makes the inviter follow the user' do
        kitty = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: kitty, recipient_email: 'ko@ko.com')
        post :create, user: {email: 'ly@ko.com', password: 'password', full_name: 'lykke li'}, invitation_token: invitation.token
        lykke = User.where(email: 'ly@ko.com').first
        expect(kitty.follows?(lykke)).to be_true
      end
      it 'expires the invitation upon acceptance' do
      kitty = Fabricate(:user)
      invitation = Fabricate(:invitation, inviter: kitty, recipient_email: 'ko@ko.com')
      post :create, user: {email: 'ly@ko.com', password: 'password', full_name: 'lykke li'}, invitation_token: invitation.token
      expect(Invitation.first.token).to be_nil

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

    context 'sending emails' do
      it 'sends out email to the user with valid inputs' do
        post :create, user: {email: 'kik@mah.se', password: 'pass', full_name: 'kik'}
        expect(ActionMailer::Base.deliveries.last.to).to eq(['kik@mah.se']) #last.to is specting that we are sending many mails
      end
      it 'sends out email containing the users name with valid inputs' do
        post :create, user: {email: 'kik@mah.se', password: 'pass', full_name: 'kik'}
        expect(ActionMailer::Base.deliveries.last.body).to include('kik')
      end
      it 'doesnt send out email with invalid  inputs' do
        post :create, user: {email: 'kik@mah.se' }
        expect(ActionMailer::Base.deliveries).to be_empty
      end

    end
  end

  describe "GET show" do

    it_behaves_like 'requires sign in' do
      let(:action) {get :show, id: 4}
    end

    it 'sets a @user' do
      set_current_user    #method from Macro
      kitty = Fabricate(:user)
      get :show, id: kitty.id
      expect(assigns(:user)).to eq(kitty)
    end

  end

  describe 'GET new_with_invitation_token' do
    it 'sets the :new-view template' do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(response).to render_template :new
    end
    it 'sets @user with recipients email' do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:user).email).to eq(invitation.recipient_email)
    end

    it 'sets @invitation_token' do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:invitation_token)).to eq(invitation.token)
    end

    it 'redirects to expired token page for invalid tokens' do
      get :new_with_invitation_token, token: 'afdsad'
      expect(response).to redirect_to expired_token_path
    end

  end

end


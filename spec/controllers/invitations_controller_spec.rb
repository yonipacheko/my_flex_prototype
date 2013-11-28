require 'spec_helper'

describe InvitationsController do
  describe 'GET new' do
    it 'sets @invitation to a new invitation' do
      # we start checking the the instance obj if it's working
      set_current_user
      get :new
      expect(assigns(:invitation)).to be_new_record
      expect(assigns(:invitation)).to be_instance_of Invitation
    end

    it_behaves_like 'requires sign in' do
      let(:action) { get :new }
    end
  end

  # Now we are going to test the POST-method: create method

  describe 'POST create' do
    # We want to make sure that authenticated users can post the invitation

    it_behaves_like 'requires sign in' do
      let(:action) { post :create }
    end
    # then we can have to contexts:
    # the fist we want to make sure that:
    context 'with valid input' do
      it 'redirects to the invitation new page' do
        set_current_user
        post :create, invitation: { recipient_name: 'Joe Smith', recipient_email: 'ko@ko.com', message: 'Hej join this site'}
        expect(response).to redirect_to new_invitation_path
      end

      it 'creates an invitation' do
        set_current_user
        post :create, invitation: { recipient_name: 'Joe Smith', recipient_email: 'ko@ko.com', message: 'Hej join this site'}
        expect(Invitation.count).to eq(1)
      end
      it 'sends an email to the recipient' do
        set_current_user
        post :create, invitation: { recipient_name: 'Joe Smith', recipient_email: 'ko@ko.com', message: 'Hej join this site'}
        expect(ActionMailer::Base.deliveries.last.to).to eq(['ko@ko.com'])
      end
      it 'sets the flash succes message'
    end


  end
end
require 'spec_helper'

describe ForgotPasswordsController do
  describe 'POST create' do
    context 'with blank email' do
      it 'redirects to the forgot password page' do
        post :create, email: ''
        expect(response).to redirect_to forgot_password_path
      end
      it 'shows an error message' do
        post :create, email: ''
        expect(flash[:error]) =~('Email cant be blank.')
      end
    end
    context 'with existing email' do
      it 'redirect to the forgot password confirmation page' do
        user = Fabricate(:user, email: 'fe@fe.org')
        post :create, email: 'fe@fe.org'
        expect(response).to redirect_to forgot_password_confirmation_path
      end
      it 'sends out an email to the email addresses' do
        user = Fabricate(:user, email: 'fe@fe.org')
        post :create, email: 'fe@fe.org'
        expect(ActionMailer::Base.deliveries.last.to).to eq(['fe@fe.org'])
      end
    end
    context 'with no-existing email'  do
      it 'redirects to the forgot_password_page' do
        post :create, email: 'fe@fe.org'
        expect(response).to redirect_to forgot_password_path
      end

      it 'shows an error message' do
        post :create, email: 'fe@fe.org'
        expect(flash[:error]) =~('There is no user with dat email in the system')

      end
    end

  end
end
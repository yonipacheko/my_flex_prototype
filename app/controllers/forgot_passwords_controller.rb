class ForgotPasswordsController < ApplicationController
  def new

  end

  def create
    user = User.where(email: params[:email]).first
    if user
      App_Mailer.send_forgot_password(user).deliver
      redirect_to forgot_password_confirmation_path
    else
      flash[:error] =  params[:email].blank? ?  'Email cant be blank' : 'u dont have a registered email'
      redirect_to forgot_password_path
    end

  end

  #def confirmation
  # we dont need this controller, enough to have a static page:
  # view without control :)
  #end
end
class PasswordResetsController < ApplicationController
  def show
    user = User.where(token: params[:id]).first # the result of where-method is an array that's why we use first
    if user
      @token = user.token
    else
      redirect_to expired_token_path

    end
  end

  def create
    user = User.where(token: params[:token]).first
    if user
      user.password = params[:password]
      #user.generated_token
      user.save
      flash[:success] = 'yr password has been changed, please sign in.'

      redirect_to sign_in_path
    else
      redirect_to expired_token_path

    end

  end
end

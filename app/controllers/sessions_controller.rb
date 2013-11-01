class SessionsController < ApplicationController
  def new
    redirect_to home_path if current_user
  end

  def create
    user =  User.where(email: params[:email]).first    #fetching up the user name from  the DB
    if user && user.authenticate(params[:password])    #having the user in the session-time
      session[:user_id] = user.id
      redirect_to home_path, notice: 'U are signed in, enjoy!!'
    else
      flash[:error] ='Invalid email or password'
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'U are signed out, thanks!'
  end
end
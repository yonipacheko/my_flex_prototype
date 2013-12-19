class Admin::VideosController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(user_params)
    #require 'pry'; binding.pry

    if @video.save
      flash[:success] = "You have succesfully added the video #{@video.title}."
      redirect_to new_admin_video_path
    else
      flash[:error] = "You can't add this video. Please check the errors"
      render :new
    end
  end

  private

    def require_admin
      if !current_user.admin?
        flash[:error] = 'You are not autorized to do dat'
        redirect_to home_path
      end
    end

    def user_params
      params.require(:video).permit!
    end

end
require 'pry'

class QueueItemsController < ApplicationController

  before_filter :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    #user1 = User.find(session[:user_id])
    #binding.pry
    QueueItem.create(video: video, user: current_user, position: current_user.queue_items.count + 1) unless current_user.queue_items.map(&:video).include?(video)
    redirect_to my_queue_path

  end
end
require 'pry'

class QueueItemsController < ApplicationController

  before_filter :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    #binding.pry

    video = Video.find(params[:video_id])
    #user1 = User.find(session[:user_id])
    queue_video(video)
    redirect_to my_queue_path

  end

  def destroy

    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user.queue_items.include?(queue_item)

    redirect_to my_queue_path
  end

  def update_queue
    begin
      ActiveRecord::Base.transaction do
        params[:queue_items].each do |queue_item_data|

          queue_item = QueueItem.find(queue_item_data[:id]) # we can't do: "queue_item_data.id", cuz it's not an attr. but a Hash remember?
          queue_item.update_attributes!(position: queue_item_data[:position])

        end # ends params-loop
      end
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Invalid type of numbers"
      redirect_to my_queue_path
      return
    end

    normalize_queue_items_positions

    redirect_to my_queue_path
  end

  private

  def normalize_queue_items_positions
    current_user.queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index + 1)
    end
  end

  def queue_video(video)
    QueueItem.create(video: video, user: current_user, position: new_queuue_item_position ) unless current_user_queue_item_video?(video)
  end

  def new_queuue_item_position
    current_user.queue_items.count + 1
  end

  def current_user_queue_item_video?(video)
    current_user.queue_items.map(&:video).include?(video)
  end
end
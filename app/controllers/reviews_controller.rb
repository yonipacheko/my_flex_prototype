#require 'pry'
class ReviewsController < ApplicationController

  before_filter :require_user

  def create
    @video = Video.find(params[:video_id])
    review = @video.reviews.build(user_params.merge!(user: current_user))
    #binding.pry
    if review.save
      redirect_to @video
    else
      @reviews = @video.reviews.reload # we reload this instance object to delete it from the DB-
      render 'videos/show'
    end

    #@video = Video.find(params[:video_id])
    #@review = Review.create(user_params)
    #@review.video = @video # associate @review with video
    #@review.user = current_user
    #
    #redirect_to video_path(@video) #@video.id

    #
    #if @review.save
    #  flash[:notice] = 'Review added!'
    #  redirect_to video_path(@video) #@video.id
    #else
    #  @reviews = @video.reviews
    #  render 'videos/show'
    #end

  end

  def  user_params
    params.require(:review).permit!
  end
end


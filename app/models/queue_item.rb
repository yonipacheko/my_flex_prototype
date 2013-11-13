require 'pry'

class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

   #delegate :category, to: :video
  #delegate :title, to: :video, prefix: :video #About the prefix: we want to call the method: video.title otherwise it should have called it like category-method above

  def rating
    review = Review.where(video_id: video.id, user_id: user.id).first
    review.rating if review
  end

  def rating=(new_rating)   # this is how U retrieve data from the Controller to the ReviewModel (this a virtual attr.)
    review = Review.where(video_id: video.id, user_id: user.id).first
    #binding.pry

    if review # if we already have one review: either nil or with data
      review.update_column(:rating, new_rating)
    else
      review = Review.new(user: user, video: video, rating: new_rating)
      review.save(validate: false)
    end
  end

  def category_name
    video.categories.first.name
    #binding.pry
  end

  # THOSE ARE CALL ABOVE AS DELEGATION - METHODS
  def category
    video.categories.first
    #binding.pry
  end

  def video_title
    video.title
  end


end
class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :videos, -> { order('created_at DESC') }, through: :categorizations

    validates :name, presence: true

  def recent_videos
    videos.first(6)
  end

end
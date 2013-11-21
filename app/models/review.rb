class Review < ActiveRecord::Base
  belongs_to :video
  belongs_to :user


  validates :content, :rating, presence: true

end

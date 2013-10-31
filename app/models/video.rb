class Video < ActiveRecord::Base
  has_many :categories, through: :categorizations
  has_many :categorizations

validates :title,  presence: true
validates :description, presence: true
end
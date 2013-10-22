class Video < ActiveRecord::Base
  has_many :categories, through: :categorizations
  has_many :categorizations
end
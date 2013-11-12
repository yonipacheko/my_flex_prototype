  class User < ActiveRecord::Base


  validates :email, :password, :full_name, presence: true
  validates_uniqueness_of :email

  has_secure_password validations: false

  has_many :queue_items, ->{order(:position)}
end
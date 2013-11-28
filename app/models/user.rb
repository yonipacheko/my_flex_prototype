  class User < ActiveRecord::Base

  validates :email, :password, :full_name, presence: true
  validates_uniqueness_of :email

  has_secure_password validations: false

  has_many :queue_items, ->{order(:position)}
  has_many :reviews, -> {order('created_at DESC')}

  # the current_user is the follower

  has_many :following_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :leading_relationships, class_name: 'Relationship', foreign_key: :leader_id

  #has_many :invitations
  before_create :generate_token #be careful with this method, it generates the token way before u think!


  def normalize_queue_items_positions
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index + 1)
    end
  end

  def queue_video?(video)
    queue_items.map(&:video).include?(video)
  end

  def follows?(other_obj)

    following_relationships.map(&:leader).include?(other_obj)

  end

  # we could use this method below, instead of unless current_user == @user || current_user.follows?(@user)
  #that u will find under user.rb || show.html.haml (user)

  def can_follow?(another_user)
    !( self.follows?(another_user) || self == another_user )
  end



  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end
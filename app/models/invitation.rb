class Invitation < ActiveRecord::Base
  include Tokenable  # this a concern taking care of generation of tokens

  belongs_to :inviter, class_name: 'User'

  validates_presence_of :recipient_name, :recipient_email, :message


end
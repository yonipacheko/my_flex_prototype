class Invitation < ActiveRecord::Base
  belongs_to :inviter, class_name: 'User'

  validates_presence_of :recipient_name, :recipient_email, :message

  before_create :generated_token

  def generated_token
    # a class variable: self.token
    token = SecureRandom.urlsafe_base64
  end
end
module Tokenable
  extend ActiveSupport::Concern
  included do
    #be careful with this method, it generates the token way before u think!
    before_create :generated_token
  end

  def generated_token
    self.token = SecureRandom.urlsafe_base64
  end

end
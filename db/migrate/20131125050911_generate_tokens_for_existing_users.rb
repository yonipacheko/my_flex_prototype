class GenerateTokensForExistingUsers < ActiveRecord::Migration
  def change
    User.all.each do |user|
      #update_column bypass any validation we have in the user model!
      user.update_column(:token, SecureRandom.urlsafe_base64)
    end
  end
end

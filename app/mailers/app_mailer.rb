class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user #we do this to wire up the connection with forgot_passwords controller
    mail to: user.email, from: 'info@myflix.com', subject: 'Welcome to Myflix!'
  end

  def send_forgot_password(user)
    @user = user #we do this to wire up the connection with forgot_passwords controller
    mail to: user.email, from: 'info@myflix.com', subject: 'Please reset yr password!'
  end

  def send_invitation_email(invitation)
    @invitation = invitation
    mail to: invitation.recipient_email, from: 'info@myflix.com', subject: 'Invitation to join my Myflix'
  end
end
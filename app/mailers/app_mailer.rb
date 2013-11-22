class App_Mailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail to: user.mail, from: 'info@myflix.com', subject: 'Welcome to Myflix!'
  end

end
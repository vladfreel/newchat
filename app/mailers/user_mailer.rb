# usermail
class UserMailer < ApplicationMailer
  default from: 'vladfreelmaster@gmail.com'
  layout 'mailer'
  def welcome_subs(user)
    send_user = User.find(user)
    mail(to: send_user.email, subject: 'Subscribe')
  end
  # heroku ps:scale worker=1
  def welcome_images(user)
    send_user = User.find(user)
    mail(to: send_user.email, subject: 'Image')
  end
end

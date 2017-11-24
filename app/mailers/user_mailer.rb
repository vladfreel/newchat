# usermail
class UserMailer < ApplicationMailer
  default from: 'vladfreelmaster@gmail.com'
  layout 'mailer'
  def new_registration(user)
    @user = user
    mail(to: user.email, subject: 'Welcome !!!')
    mail(
      to: 'wolf_1396@mail.ru',
      subject: 'New User created please review and enable.'
    )
  end

  def new_sign_in(user)
    @user = user
    mail(to: user.email, subject: 'Hello !!!')
  end

  def new_sign_out(user)
    @user = user
    mail(to: user.email, subject: 'Goodbye !!!')
  end

  def send_admin_mail(user)
    @user = user
    mail(to: user.email, subject: 'Hello !!!')
  end

  def welcome_subs(user)
    @user = user
    mail(to: @user.email, subject: 'Subscribe')
  end

  def welcome_images(user)
    @user = user
    mail(to: @user.email, subject: 'Image')
  end
end

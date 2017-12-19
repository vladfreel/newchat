ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
      address:               'smtp.gmail.com',
      port:                  587,
      domain:                'stelschat.herokuapp.com',
      user_name:             ENV['EMAIl'],
      password:              ENV['PASSWORD'],
      authentication:        'plain',
      enable_starttls_auto:  true
}

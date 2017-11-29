# OmniauthCallbacksController
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user.persisted?
      sign_in_and_redirect user, notice: 'Signed in!!!'
      action_t = 'Sign in'
      event_create(action_t)
    else
      session['devise.user_attributes'] = user.attributes
      sign_in_and_redirect user
      action_t = 'Sign in'
      event_create(action_t)
    end
  end
  def instagram
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user.persisted?
      sign_in_and_redirect user, notice: 'Signed in!!!'
      action_t = 'Sign in'
      event_create(action_t)
    else
      session['devise.user_attributes'] = user.attributes
      sign_in_and_redirect user
      action_t = 'Sign in'
      event_create(action_t)
    end
  end
end

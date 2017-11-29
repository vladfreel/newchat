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
      redirect_to new_user_registration_url
    end
  end
  def facebook
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user.persisted?
      sign_in_and_redirect user, notice: 'Signed in!!!'
      action_t = 'Sign in'
      event_create(action_t)
    else
      session['devise.user_attributes'] = user.attributes
      redirect_to new_user_registration_url
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
      us = User.create(user.attributes)
      sign_in_and_redirect us
      action_t = 'Sign in'
      event_create(action_t)
    end
  end
end

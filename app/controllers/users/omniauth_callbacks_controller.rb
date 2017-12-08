# OmniauthCallbacksController
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user.persisted?
      sign_in_and_redirect user
      action_t = 'Sign in'
      event_create(action_t)
    else
      session['devise.user_attributes'] = user.attributes
      sign_in_and_redirect user
      action_t = 'Sign in'
      event_create(action_t)
    end
  end

  private
  def after_sign_in_path_for(resource)
    categories_path
  end
  def event_create(a_t)
    Event.create(user_id: current_user.id, action_type: a_t,
                 orig_url: request.original_url)
  end

end

# SessionsController
class Users::SessionsController < Devise::SessionsController
after_action :user_sign_in, only: :create
before_action :user_sign_out, only: :destroy

  def user_sign_in
    action_t = 'Sign in'
    event_create(action_t)
  end
  def user_sign_out
    action_t = 'Sign out'
    event_create(action_t)
  end
private

  def event_create(a_t)
    Event.create(user_id: current_user.id, action_type: a_t,
                 orig_url: request.original_url)
  end
end

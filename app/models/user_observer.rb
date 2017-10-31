class UserObserver < ActiveRecord::Observer
  def after_sign_in(event)
    event.user_id = current_user
  end
end

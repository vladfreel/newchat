# All other controllers inherit from ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_sign_up, if: :devise_controller?
  before_action :configure_account_update, if: :devise_controller?
  before_action :log_click, unless: :devise_controller?
  before_action :set_locale
  protect_from_forgery with: :null_session
  def configure_sign_up
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:username, :email, :password, :password_confirmation,
               :remember_me, :avatar, :avatar_cache, :remove_avatar)
    end
  end

  def configure_account_update
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:username, :email, :password, :password_confirmation,
               :current_password, :avatar, :avatar_cache, :remove_avatar)
    end
  end

  private

  def popular
    @out = Category.select('categories.*,
    COUNT(images.id) AS t_count').joins(:images).group('
    categories.id').order('t_count DESC').limit(5)
  end

  def event_create(a_t)
    Event.create(user_id: current_user.id, action_type: a_t,
                 orig_url: request.original_url)
  end

  def subsribes
    category = Category.find(params[:id])
    @sub = category.subs.find_by(user: current_user)
  end

  def log_click
    if current_user.nil?
    else
    Event.create(user_id: current_user.id,
                 action_type: 'Navigation',
                 orig_url: request.original_url)
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end
end

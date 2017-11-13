class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :log_click, unless: :devise_controller?
  before_action :set_locale
  protect_from_forgery with: :null_session
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username,
                                                               :email,
                                                               :password,
                                                               :password_confirmation,
                                                               :remember_me,
                                                               :avatar,
                                                               :avatar_cache,
                                                               :remove_avatar) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username,
                                                                      :email,
                                                                      :password,
                                                                      :password_confirmation,
                                                                      :current_password,
                                                                      :avatar,
                                                                      :avatar_cache,
                                                                      :remove_avatar) }

  end
  def log_click
    if current_user.nil?
    else
      event = Event.new(user_id: current_user.id, action_type: "Navigation",orig_url: request.original_url)
      event.save!
    end
  end
  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  def default_url_options(options = {})
    {locale: I18n.locale}.merge options
  end

end


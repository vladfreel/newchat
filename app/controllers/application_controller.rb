class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :log_click, unless: :devise_controller?

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  def log_click
    if current_user.nil?
    else
      event = Event.new(user_id: current_user.id, action_type: "Navigation",orig_url: request.original_url)
      event.save!
    end

  end


end


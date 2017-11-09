class Users::SessionsController < Devise::SessionsController
   before_action :configure_sign_in_params, only: [:create]
   before_action :conf

   def conf
     UserMailer.new_sign_in(current_user).deliver
   end
   def create
     flash.clear

     user = User.find_by_email(sign_in_params['email'])
     super and return unless user

     adjust_failed_attempts user

     super and return if (user.failed_attempts < User.logins_before_captcha)
     super and return if user.access_locked? or verify_recaptcha

     # Don't increase failed attempts if Recaptcha was not passed
     decrement_failed_attempts(user) if recaptcha_present?(params) and
         !verify_recaptcha

     # Recaptcha was wrong
     self.resource = resource_class.new(sign_in_params)
     sign_out
     flash[:error] = 'Captcha was wrong, please try again.'
     respond_with_navigational(resource) { render :new }
   end
   def after_sign_in_path_for(resource)
     resource.update cached_failed_attempts: 0, failed_attempts: 0
     root_path
   end
   private def adjust_failed_attempts(user)
     if user.failed_attempts > user.cached_failed_attempts
       user.update cached_failed_attempts: user.failed_attempts
     else
       increment_failed_attempts(user)
     end
   end

   private def increment_failed_attempts(user)
     user.increment :cached_failed_attempts
     user.update failed_attempts: user.cached_failed_attempts
   end

   private def decrement_failed_attempts(user)
     user.decrement :cached_failed_attempts
     user.update failed_attempts: user.cached_failed_attempts
   end

   private def recaptcha_present?(params)
     params[:recaptcha_challenge_field]
   end
end

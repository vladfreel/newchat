class Users::SessionsController < Devise::SessionsController
   before_action :configure_sign_in_params, only: [:create]
   prepend_before_action :check_captcha, only: [:create] # Change this to be any actions you want to protect.

   def check_captcha
     unless verify_recaptcha
       self.resource = resource_class.new
       resource.validate # Look for any other validation errors besides Recaptcha
       respond_with_navigational(resource) { render :new }
     end
   end
   def create
     flash.clear
     UserMailer.new_sign_in(current_user).deliver
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

       UserMailer.new_registration(user).deliver
      #event = Event.new(user_id: current_user.id, action_type: "Sign in",orig_url: request.original_url)
      #event.save!
   end
   def destroy
     #event = Event.new(user_id: current_user.id, action_type: "Sign Out",orig_url: request.original_url)
     #event.save!
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
     @user = User.new(params[:user].permit(:name))
     if verify_recaptcha(model: @user) && @user.save
       redirect_to @user
     else
       render 'new'
     end
   end
end

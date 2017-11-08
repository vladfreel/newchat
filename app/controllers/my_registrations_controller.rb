class MyRegistrationsController < Devise::RegistrationsController

    def create
      super
      if @user.persisted?
        UserMailer.new_registration(current_user).deliver
      end
    end

end

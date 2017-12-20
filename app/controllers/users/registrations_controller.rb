# RegistrationsController
class Users::RegistrationsController < Devise::RegistrationsController
  def edit
    popular
    @categories = Category.all
    @categories_sub = current_user.categories
  end
end

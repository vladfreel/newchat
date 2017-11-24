# RegistrationsController
class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    @res = resource
    Resque.enqueue(RegMail, @res)
  end
end

# this controller is responsible for the operation with users(devise)
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @user = User.all
  end
end

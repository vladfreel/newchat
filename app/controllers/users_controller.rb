class UsersController < ApplicationController
  after_action :conf, if: :user_signed_in?
  def conf
    event = Event.new(user_id: current_user.id, signin: DateTime.now, dtnow: DateTime.now)
    event.save!
  end
  def show
    @user = User.find(params[:id])
  end
  def edit

  end
  def index
    @user = User.all
  end

end

# this controller is responsible for the operation with subscribes
class SubsController < ApplicationController
  before_action :create_subscribe_event, only: [:create]
  before_action :delete_subscribe_event, only: [:destroy]
  def new
    @sub = Sub.new
  end

  def create
    @category = Category.find(params[:category_id])
    @sub = @category.subs.create(sub_params)
    @sub.save
    @subs = @sub.id
    Resque.enqueue(SubMail, @subs)
    redirect_to @category
  end

  def destroy
    @category = Category.find(params[:category_id])
    @sub = @category.subs.find(params[:id])
    @sub.destroy
    redirect_to @category
  end

  private

  def create_subscribe_event
    Event.create(
      user_id: current_user.id,
      action_type: ' Subscribe category where category_id = ' +
      @category.id.to_s, orig_url: request.original_url
    )
  end

  def delete_subscribe_event
    Event.create(
      user_id: current_user.id,
      action_type: ' Unsubscribe category where category_id = ' +
      @category.id.to_s, orig_url: request.original_url
    )
  end

  def sub_params
    params.require(:sub).permit(:user_id, :category_id)
  end
end

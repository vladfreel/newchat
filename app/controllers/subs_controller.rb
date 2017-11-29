# this controller is responsible for the operation with subscribes
class SubsController < ApplicationController
  def new
    @sub = Sub.new
  end

  def create
    @category = Category.find(params[:category_id])
    @sub = @category.subs.create(sub_params)
    @sub.save
    action_t = ' Subscribe category where category_id = ' + @category.id.to_s
    event_create(action_t)
    if current_user.login.nil?
    else
      Resque.enqueue(SubMail, @category.owner.id)
    end
    redirect_to @category
  end

  def destroy
    @category = Category.find(params[:category_id])
    @sub = @category.subs.find(params[:id])
    @sub.destroy
    action_t = ' Unsubscribe category where category_id = ' + @category.id.to_s
    event_create(action_t)
    redirect_to @category
  end

  private

  def sub_params
    params.require(:sub).permit(:user_id, :category_id)
  end
end

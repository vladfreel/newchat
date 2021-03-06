# this controller is responsible for the operation with subscribes
class SubsController < ApplicationController
  before_action :authenticate_user!
  def create
    @category = Category.friendly.find(params[:category_id])
    @sub = @category.subs.create(sub_params)
    @sub.save!
    action_t = ' Subscribe category where category_id = ' + @category.id.to_s
    event_create(action_t)
    sub_mail(@category)
    redirect_to @category
  end

  def destroy
    @category = Category.friendly.find(params[:category_id])
    @sub = @category.subs.find(params[:id])
    @sub.destroy
    action_t = ' Unsubscribe category where category_id = ' + @category.id.to_s
    event_create(action_t)
    redirect_to @category
  end

  private

  def sub_mail(category)
    if current_user.login.nil?
    else
      Resque.enqueue(SubMail, category.owner.id)
    end
  end

  def event_create(a_t)
    Event.create(user_id: current_user.id, action_type: a_t,
                 orig_url: request.original_url)
  end

  def sub_params
    params.require(:sub).permit(:user_id, :category_id)
  end
end

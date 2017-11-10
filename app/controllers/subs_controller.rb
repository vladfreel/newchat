class SubsController < ApplicationController
  def new
    @sub = Sub.new
  end
  def create
    @category = Category.find(params[:category_id])
    @sub = @category.subs.create(sub_params)
    @sub.save
    UserMailer.welcome_subs(@sub.user).deliver
    redirect_to @category
  end
  def destroy
    @category = Category.find(params[:category_id])
    @sub = @category.subs.find(params[:id])
    @sub.destroy
    redirect_to @category
  end
  private
  def sub_params
    params.require(:sub).permit(:user_id,:category_id)
  end
end

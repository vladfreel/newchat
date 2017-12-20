# this controller is responsible for the operation with categories
class CategoriesController < ApplicationController
  before_action :authenticate_user!
  def new
    popular
    @categories = Category.all
    @categories_sub = current_user.categories
    @category = Category.new
  end

  def create
    @categories_sub = current_user.categories
    @category = Category.new(category_params)
    @category.save
    action_t = ' Create category where category_id = ' + @category.id.to_s
    event_create(action_t)
    redirect_to @category
  end

  def show
    popular
    subsribes
    @categories = Category.all
    @categories_sub = current_user.categories
    @category = Category.friendly.find(params[:id])
    @images = Image.where(category_id: @category.id).page(params[:page]).per(9)
  end

  def index
    popular
    @categories = Category.all
    @categories_sub = current_user.categories
  end

  def destroy
    @category = Category.friendly.find(params[:id])
    @category.destroy
    action_t = ' Delete category where category_id = ' + @category.id.to_s
    event_create(action_t)
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :user_id,
                                     :_destroy)
  end
end

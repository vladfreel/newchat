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
    @category = Category.find(params[:id])
  end

  def index
    popular
    @categories = Category.all
    @categories_sub = current_user.categories
  end

  def destroy
    @category = Category.find(params[:id])
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

  def popular
    @out = Category.select(
        'categories.*, COUNT(images.id) AS t_count'
    ).joins(
        :images
    ).group(
        'categories.id'
    ).order(
        't_count DESC'
    ).limit(5)
  end

  def event_create(a_t)
    Event.create(user_id: current_user.id, action_type: a_t,
                 orig_url: request.original_url)
  end

  def subsribes
    category = Category.find(params[:id])
    @sub = category.subs.find_by(user: current_user)
  end
end

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
    Event.create(
      user_id: current_user.id,
      action_type: ' Create category where category_id = ' +
      @category.id.to_s, orig_url: request.original_url
    )
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

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    destroy_category_event
    @category.destroy
    Event.create(
      user_id: current_user.id,
      action_type: ' Delete category where category_id = ' +
      @category.id.to_s, orig_url: request.original_url
    )
    redirect_to categories_path
  end

  private
  def category_params
    params.require(:category).permit(
      :name,
      :user_id,
      :_destroy
    )
  end
end

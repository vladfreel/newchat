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
    redirect_to @category
  end

  def show
    popular
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
    @category.destroy
    redirect_to categories_path
  end

  private
  def popular
    @out = Category.select("categories.*, COUNT(images.id) AS t_count").joins(:images).group("categories.id").order("t_count DESC").limit(5)
  end
  def category_params
    params.require(:category).permit(:name,:user_id, :_destroy)
  end

end
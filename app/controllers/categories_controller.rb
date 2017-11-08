class CategoriesController < ApplicationController
  before_action :authenticate_user!
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to @category
  end

  def show
    @category = Category.find(params[:id])
    @sub = @category.subs.find_by( user: current_user)
  end

  def index
    @categories = Category.all
    @subs = Sub.find_by( user_id: current_user)    # getting subs where user = current_user
    if @subs.nil?
    else
      @cat = Category.find(@subs.category.id)
      @images = @cat.images.where(category_id: @cat)
    end

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
  def check
    sub = Sub.find_by(user_id: current_user.id,category_id: @category.id)
    if sub.nil?
      true
    else
      false
    end
  end
  private

  def category_params
    params.require(:category).permit(:name,:user_id, :_destroy)
  end

end
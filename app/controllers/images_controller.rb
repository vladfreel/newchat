class ImagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @category = Category.find(params[:category_id])
    @image = @category.images.create(image_params)
    if @image.img.nil?
      @image.save
      @user = current_user.id
      Resque.enqueue(ImageMail, @user)
    else
      redirect_to category_path(@category)
    end
  end

  def show
    popular
    @categories = Category.all
    @image = Image.find(params[:id])
    @like = @image.likes.find_by( user: current_user)
    @categories_sub = current_user.categories
  end

  def index
    popular
    @categories = Category.all
    @categories_sub = current_user.categories
    @images = Image.all.page(params[:page]).per(5)
  end

  def update
    @image = Image.find(params[:id])
    @image.update(likes: @image.likes+1)
    @image.save
    redirect_to category_image_path(@image)
  end

  private
  def image_params
    params.require(:image).permit(:path, :category_id, :user_id, :img)
  end
  def popular
    @out = Category.select("categories.*, COUNT(images.id) AS t_count").joins(:images).group("categories.id").order("t_count DESC").limit(5)
  end
end



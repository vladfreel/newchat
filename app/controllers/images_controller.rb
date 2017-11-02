class ImagesController < ApplicationController
  def create
    @category = Category.find(params[:category_id])
    @image = @category.images.create(image_params)
    redirect_to category_path(@category)
  end
  def show
    @image = Image.find(params[:id])
    @like = @image.likes.find_by( user: current_user)
  end
  def edit

  end
  def index
    @images = Image.all
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
end



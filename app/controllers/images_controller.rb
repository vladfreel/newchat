class ImagesController < ApplicationController
  def create
    @category = Category.find(params[:category_id])
    @image = @category.images.create(image_params)
    if current_user.nil?
      @image.save!
    else
      @image.save!
      @user = current_user.id
      Resque.enqueue(ImageMail, @user)

      redirect_to category_path(@category)
    end


  end
  def show
    @image = Image.find(params[:id])
    @like = @image.likes.find_by( user: current_user)
  end
  def edit

  end
  def index
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
end



# this controller is responsible for the operation with images
class ImagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @category = Category.find(params[:category_id])
    @image = @category.images.create(image_params)
    if @image.img.nil?
      redirect_to category_path(@category)
    else
      @image.save!
      Event.create(
        user_id: current_user.id,
        action_type:'Add Image where Image_id = ' +
        @image.id.to_s, orig_url: request.original_url
      )
      @user = current_user.id
      Resque.enqueue(ImageMail, @user)
      redirect_to category_path(@category)
    end
  end

  def show
    popular
    @categories = Category.all
    @image = Image.find(params[:id])
    @like = @image.likes.find_by(user: current_user)
    @categories_sub = current_user.categories
  end

  def index
    popular
    @categories = Category.all
    @categories_sub = current_user.categories
    @images = Image.all.page(params[:page]).per(5)
  end

  private
  def image_params
    params.require(:image).permit(:path, :category_id, :user_id, :img)
  end
end

# this controller is responsible for the operation with images
class ImagesController < ApplicationController
  before_action :authenticate_user!
  def create
    @category = Category.find(params[:category_id])
    @image = @category.images.create(image_params)
    @image.save
    action_t = 'Add Image where Image_id = ' + @image.id.to_s
    event_create(action_t)
    image_mail(@category)
    redirect_to category_path(@category)
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

  def image_mail(category)
    subs = category.subs
    subs.each do |s|
      Resque.enqueue(ImageMail, s.user.id)
    end
  end

  def image_params
    params.require(:image).permit(:path, :category_id,
                                  :user_id, :img, :remote_img_url)
  end
end

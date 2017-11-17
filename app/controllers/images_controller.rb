class ImagesController < ApplicationController
  def create
    @category = Category.find(params[:category_id])
    @image = @category.images.create(image_params)
    if current_user.nil? || @image.img.nil?
      @image.save!
    else
      @image.save!
      @user = current_user.id
      Resque.enqueue(ImageMail, @user)

      redirect_to category_path(@category)
    end


  end
  def show
    categories_popular = Category.all.each_with_object({}) do |account, hash|
      hash[account.name] = account.images.count
    end
    sorted = categories_popular.sort_by { |acc, ct| ct }.reverse
    @out = Array.new
    sorted.take(5).each do |h|
      @out << Category.where(name: h[0])
    end
    @categories = Category.all
    @subs = Sub.find_by( user_id: current_user)    # getting subs where user = current_user
    if @subs.nil?
    else
      @cat = Category.find(@subs.category.id)
      @images = @cat.images.where(category_id: @cat)
    end

    @image = Image.find(params[:id])
    @like = @image.likes.find_by( user: current_user)
  end
  def edit

  end
  def index
    categories_popular = Category.all.each_with_object({}) do |account, hash|
      hash[account.name] = account.images.count
    end
    sorted = categories_popular.sort_by { |acc, ct| ct }.reverse
    @out = Array.new
    sorted.take(5).each do |h|
      @out << Category.where(name: h[0])
    end
    @categories = Category.all
    @subs = Sub.find_by( user_id: current_user)    # getting subs where user = current_user
    if @subs.nil?
    else
      @cat = Category.find(@subs.category.id)
      @images = @cat.images.where(category_id: @cat)
    end

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



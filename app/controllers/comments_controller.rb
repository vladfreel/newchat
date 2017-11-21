class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @image = Image.find(params[:image_id])
    @comment = @image.comments.new(comment_params)
    @comment.save
    event = Event.new(user_id: current_user.id, action_type: "Comment where id = "+@comment.id.to_s+" and Image_id = "+@image.id.to_s,orig_url: request.original_url)
    event.save
    redirect_to category_image_path(@image.category_id,@image.id)
    @categories_sub = current_user.categories

  end
  def update
    @comment.update(user_id: current_user)
    @comment.save
    redirect_to category_image_path(@image.category_id,@image.id)
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
    @categories_sub = current_user.categories

    @comments = Comment.all.page(params[:page]).per(8)
  end

  private
  def comment_params
    params.require(:comment).permit(:com_email, :body, :user_id)
  end
end

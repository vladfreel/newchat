# this controller is responsible for the operation with comments
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :search_subs, only: [:create]

  def create
    @image = Image.find(params[:image_id])
    @comment = @image.comments.new(comment_params)
    @comment.save!
    action_t = ' Comment where id = ' + @comment.id.to_s + ' and Image_id = ' + @image.id.to_s
    event_create(action_t)
    redirect_to category_image_path(@image.category_id, @image.id)
  end

  def index
    popular
    @categories = Category.all
    @categories_sub = current_user.categories
    @comments = Comment.all.page(params[:page]).per(8)
  end

  private

  def search_subs
    @categories_sub = current_user.categories
  end

  def popular
    @out = Category.select(
        'categories.*, COUNT(images.id) AS t_count'
    ).joins(
        :images
    ).group(
        'categories.id'
    ).order(
        't_count DESC'
    ).limit(5)
  end

  def event_create(a_t)
    Event.create(user_id: current_user.id, action_type: a_t,
                 orig_url: request.original_url)
  end

  def subsribes
    category = Category.find(params[:id])
    @sub = category.subs.find_by(user: current_user)
  end

  def comment_params
    params.require(:comment).permit(:com_email, :body, :user_id)
  end
end

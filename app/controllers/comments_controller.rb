# this controller is responsible for the operation with comments
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :create_comment, only: [:create]
  before_action :create_event, only: [:create]
  before_action :search_subs, only: [:create]
  def create
    redirect_to category_image_path(@image.category_id, @image.id)
  end

  def update
    @comment.update(user_id: current_user)
    @comment.save
    redirect_to category_image_path(@image.category_id, @image.id)
  end

  def index
    popular
    @categories = Category.all
    @categories_sub = current_user.categories
    @comments = Comment.all.page(params[:page]).per(8)
  end

  private

  def create_comment
    @image = Image.find(params[:image_id])
    @comment = @image.comments.new(comment_params)
    @comment.save
  end

  def create_event
    Event.create(
      user_id: current_user.id,
      action_type: ' Comment where id = ' +
      @comment.id.to_s +
      ' and Image_id = ' +
      @image.id.to_s, orig_url: request.original_url
    )
  end

  def search_subs
    @categories_sub = current_user.categories
  end

  def comment_params
    params.require(:comment).permit(:com_email, :body, :user_id)
  end
end

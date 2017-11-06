class CommentsController < ApplicationController
  def create
    @image = Image.find(params[:image_id])
    @comment = @image.comments.new(comment_params)
    @comment.save
    event = Event.new(user_id: current_user.id, action_type: "Comment where id = "+@comment.id.to_s+" and Image_id = "+@image.id.to_s,orig_url: request.original_url)
    event.save
    redirect_to category_image_path(@image.category_id,@image.id)
  end
  def update
    @comment.update(user_id: current_user)
    @comment.save
    redirect_to category_image_path(@image.category_id,@image.id)
  end
  def index
    @comments = Comment.all.page(params[:page]).per(8)
  end

  private
  def comment_params
    params.require(:comment).permit(:com_email, :body, :user_id)
  end
end

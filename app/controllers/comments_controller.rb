class CommentsController < ApplicationController

  def create
    @image = Image.find(params[:image_id])
    @comment = @image.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save!
    redirect_to category_image_path(@image.category_id,@image.id)
  end
  def update
    @comment.update(user_id: current_user)
    @comment.save
    redirect_to category_image_path(@image.category_id,@image.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:com_email, :body)
  end

end

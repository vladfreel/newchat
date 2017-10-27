class CommentsController < ApplicationController
  before_filter :authenticate_user!, except => [:show, :index]
  def create
    @image = Image.find(params[:image_id])
    @comment = @image.comments.create(comment_params)
    redirect_to category_image_path(@image.category_id,@image.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:com_email, :body)
  end
end

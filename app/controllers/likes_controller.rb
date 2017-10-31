class LikesController < ApplicationController
  def create
    @image = Image.find(params[:image_id])
    @like = @image.likes.new(comment_params)
    @like.save
    redirect_to category_image_path(@image.category_id,@image.id)
  end
  def index
    @likes = Like.all
  end
  def destroy
    @image = Image.find(params[:image_id])
    @like = @image.likes.find(params[:id])
    @like.destroy
    redirect_to category_image_path(@image.category_id,@image.id)
  end

  private
  def comment_params
    params.require(:like).permit(:image_id, :user_id)
  end

end

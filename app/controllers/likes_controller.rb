class LikesController < ApplicationController
  def create
    @image = Image.find(params[:image_id])
    @like = @image.likes.new(comment_params)
    @like.save
    event = Event.new(user_id: current_user.id, action_type: "Like where id = "+@like.id.to_s+" and Image_id = "+@image.id.to_s,orig_url: request.original_url)
    event.save
    redirect_to category_image_path(@image.category_id,@image.id)
  end
  def index
    @likes = Like.all
  end
  def destroy
    @image = Image.find(params[:image_id])
    @like = @image.likes.find(params[:id])
    event = Event.new(user_id: current_user.id, action_type: "DisLike where id = "+@like.id.to_s+" and Image_id = "+@image.id.to_s,orig_url: request.original_url)
    event.save
    @like.destroy
    redirect_to category_image_path(@image.category_id,@image.id)
  end
  private
  def comment_params
    params.require(:like).permit(:image_id, :user_id)
  end
end

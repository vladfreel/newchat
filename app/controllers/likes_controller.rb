# this controller is responsible for the operation with likes
class LikesController < ApplicationController
  before_action :create_like, only: [:create]
  before_action :create_event_like, only: [:create]
  before_action :create_dislike, only: [:destroy]
  before_action :create_event_dislike, only: [:destroy]
  def create
    redirect_to category_image_path(@image.category_id, @image.id)
  end

  def index
    @likes = Like.all
  end

  def destroy
    redirect_to category_image_path(@image.category_id, @image.id)
  end

  private

  def create_like
    @image = Image.find(params[:image_id])
    @like = @image.likes.new(comment_params)
    @like.save
  end

  def create_event_like
    Event.create(
      user_id: current_user.id,
      action_type: 'Like where id = ' +
      @like.id.to_s +
      ' and Image_id = ' +
      @image.id.to_s, orig_url: request.original_url
    )
  end

  def create_dislike
    @image = Image.find(params[:image_id])
    @like = @image.likes.find(params[:id])
    @like.destroy
  end

  def create_event_dislike
    Event.create(
      user_id: current_user.id,
      action_type: 'DisLike where id = ' +
      @like.id.to_s +
      ' and Image_id = ' +
      @image.id.to_s,
      orig_url: request.original_url
    )
  end

  def comment_params
    params.require(:like).permit(:image_id, :user_id)
  end
end

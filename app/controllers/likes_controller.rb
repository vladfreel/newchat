# this controller is responsible for the operation with likes
class LikesController < ApplicationController

  def create
    @image = Image.find(params[:image_id])
    @like = @image.likes.new(comment_params)
    @like.save!
    action_t = 'Like where id = ' + @like.id.to_s +
        ' and Image_id = ' + @image.id.to_s
    event_create(action_t)
    redirect_to category_image_path(@image.category_id, @image.id)
  end

  def destroy
    @image = Image.find(params[:image_id])
    @like = @image.likes.find(params[:id])
    @like.destroy
    action_t = 'DisLike where id = ' + @like.id.to_s +
        ' and Image_id = ' + @image.id.to_s
    event_create(action_t)
    redirect_to category_image_path(@image.category_id, @image.id)
  end

  private

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
    params.require(:like).permit(:image_id, :user_id)
  end
end

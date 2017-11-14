class ImageMail
  @queue = :image_queue
  def self.perform(user_id)
    curr_user = User.find(user_id)
    UserMailer.welcome_images(curr_user).deliver
  end
end
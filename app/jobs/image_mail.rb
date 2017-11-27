# imagemail
class ImageMail
  @queue = :image_queue
  def self.perform(user_id)
    UserMailer.welcome_images(user_id).deliver
  end
end

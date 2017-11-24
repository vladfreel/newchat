# upload avatar for user(devise)
class AvatarUploader < CarrierWave::Uploader::Base
  if Rails.env.development?
    storage :file
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  elsif Rails.env.production?
    include Cloudinary::CarrierWave
  end
end

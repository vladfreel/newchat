# upload image
class ImgUploader < CarrierWave::Uploader::Base
  if Rails.env.development?
    storage :file
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  elsif Rails.env.production?
    include Cloudinary::CarrierWave
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
  def content_type_whitelist
    /image\//
  end
end

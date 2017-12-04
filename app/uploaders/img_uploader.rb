# upload image
class ImgUploader < CarrierWave::Uploader::Base
  if Rails.env.development?
    storage :file
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  elsif Rails.env.production?
    include Cloudinary::CarrierWave
  else
    CarrierWave.configure do |config|
      config.storage = :file
      config.enable_processing = false
    end
    ImgUploader

    # use different dirs when testing
    CarrierWave::Uploader::Base.descendants.each do |klass|
      next if klass.anonymous?
      klass.class_eval do
        def cache_dir
          "#{Rails.root}/spec/support/uploads/tmp"
        end

        def store_dir
          "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
        end
      end
    end
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
  def content_type_whitelist
    /image\//
  end
end
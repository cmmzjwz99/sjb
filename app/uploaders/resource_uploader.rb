class ResourceUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "files/headlines/#{model.class.to_s.underscore}/#{model.id}"
  end
end

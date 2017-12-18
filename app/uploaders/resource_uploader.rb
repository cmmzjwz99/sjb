class ResourceUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick


  #storage :file

  def store_dir
    "files/yzdtest/#{model.class.to_s.underscore}/#{model.id}"
  end
end

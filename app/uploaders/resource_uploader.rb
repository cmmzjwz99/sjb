class ResourceUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  #include CarrierWave::MimeTypes
  #include Piet::CarrierWaveExtension

  #process :optimize

  def store_dir
    "qr/#{model.class.to_s.underscore}/#{model.id}"
  end
end

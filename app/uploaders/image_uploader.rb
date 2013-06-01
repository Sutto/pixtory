class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include CarrierWave::UploadedImageProcessing
  include CarrierWave::MimeTypes

  process :set_content_type

  version :primary do
    process normalize_uploaded_image: 90
    process resize_to_fill: [1000, 1000]
  end

  version :thumb do
    process normalize_uploaded_image: 90
    process resize_to_fill: [300, 300]
  end

  def store_dir
    "uploads/#{Rails.env}/images/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Random filename code from the Carrierwave wiki... of doom!

  def filename
     @name ||= "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end

end

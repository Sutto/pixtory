class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include CarrierWave::UploadedImageProcessing
  include CarrierWave::MimeTypes

  SIZES = {
    primary:    [600, 600],
    thumb:      [300, 300],
    grid_base:  [180, :relative],
    grid_full:  [400, :relative],
    repostable: [612, 612]
  }

  def self.size_for(width, height, name)
    if name == :full
      return [width, height]
    else
      w, h = SIZES[name]
      if w == :relative
        w = (h.to_f / height) * width
      elsif h == :relative
        h = (w.to_f / width) * height
      end
      return [w, h]
    end
  end

  process :set_content_type
  process :store_geometry

  version :primary do
    process normalize_uploaded_image: 90
    process resize_to_fill: SIZES[:primary]
  end

  version :grid_base do
    process normalize_uploaded_image: 90
    process resize_to_width: SIZES[:grid_base].first
  end

  version :grid_full do
    process normalize_uploaded_image: 90
    process resize_to_width: SIZES[:grid_full].first
  end

  version :thumb do
    process normalize_uploaded_image: 90
    process resize_to_fill: SIZES[:thumb]
  end

  version :repostable do
    process normalize_uploaded_image: 90
    process resize_to_fill: SIZES[:repostable]
  end

  def store_dir
    "uploads/#{Rails.env}/images/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Random filename code from the Carrierwave wiki... of doom!

  def filename
     @name ||= "image.#{file.extension}" if original_filename.present?
  end

  def store_geometry
    if file && model
      image        = MiniMagick::Image.open file.file
      model.width  = image[:width]
      model.height = image[:height]
    end
  end

end

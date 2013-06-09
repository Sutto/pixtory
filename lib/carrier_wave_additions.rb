# Modified version of code from @mariovisic
# Original available from https://gist.github.com/mariovisic/965983
module CarrierWave
  module UploadedImageProcessing

    # Given an uploaded image, will:
    # 1. Strip out any extra exif metadata
    # 2. Autoorient the image using data in exif
    # 3. Reduce the quality to 90% (or a user specified quality)
    def normalize_uploaded_image(quality = 90)
      manipulate! do |img|
        img.auto_orient
        img.strip
        img.quality quality.to_s if quality.present?
        img = yield(img) if block_given?
        img
      end
    end

    def resize_to_width(width)
      manipulate! do |img|
        img.resize "#{width}x"
        img = yield(img) if block_given?
        img
      end
    end

  end
end
CarrierWave.configure do |config|
  config.enable_processing = !Rails.env.test?
  if ENV['S3_ACCESS_KEY_ID'].present?
    config.storage         = :fog
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['S3_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['S3_SECRET_ACCESS_KEY']
    }
    config.fog_directory  = ENV['S3_BUCKET_KEY']
    config.fog_public     = true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  else
    config.storage = :file
  end
end
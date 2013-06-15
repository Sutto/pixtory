require 'tempfile'
require 'kml_feed_generator'

class DumpGenerator

  def self.default_storage
    if ENV['S3_ACCESS_KEY_ID'].present?
      remote_storage
    else
      local_storage
    end
  end

  def self.local_storage
    @local_storage ||= Fog::Storage.new(provider: 'Local', local_root: Rails.root.join('tmp', 'dumps'))
  end

  def self.remote_storage
    @remote_storage ||= begin
      key_id            = ENV['S3_ACCESS_KEY_ID'],
      secret_access_key = ENV['S3_SECRET_ACCESS_KEY']
      raise "You must provide S3 details" if key_id.blank? or secret_access_key.blank?
      Fog::Storage.new({
        provider:              'AWS',
        aws_access_key_id:     key_id,
        aws_secret_access_key: secret_access_key
      })
    end
  end

  attr_reader :storage, :logger

  def initialize(storage, logger = Rails.logger)
    @storage = storage
    @logger  = logger
  end

  def dump_all
    logger.info "Generating all dumps"
    dump_geojson
    dump_kml
  end

  def dump_geojson
    logger.info "About to generate GeoJSON"
    generate_and_upload 'moments.geojson' do |file|
      serialized = MomentGeoJsonSerializer.collection(file)
      file.puts ActiveSupport::JSON.encode(serialized)
    end
    logger.info "Generated GeoJSON"
  end

  def dump_kml
    logger.info "About to generate KML"
    generate_and_upload 'moments.kml' do |file|
      rendered = KmlFeedGenerator.render(moments)
      file.write rendered
    end
    logger.info "Generated KML"
  end

  def moments
    # TODO: This needs to be refactored as data grows.
    @moments ||= Moment.all
  end

  def generate_and_upload(name)
    file = Tempfile.new(name)
    yield file if block_given?
    file.flush
    file.rewind
    # TODO: Upload file here
    directory.files.create key: name, body: file, public: true
  ensure
    file.close
  end

  def directory
    @directory ||= begin
      dir_name = ENV['S3_BUCKET_KEY'] || "pixtory-dumps"
      storage.directories.new(key: dir_name, public: true)
    end
  end

end

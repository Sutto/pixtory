class Moment < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  validates :image, :caption, :location, :coordinates, presence: true
  # validates :image, integrity: true, processing: true

  def self.from_source(name, value)
    scope = where(external_key: name.to_s, external_identifier: value.to_s)
    scope.first || scope.build
  end

  def self.random
    order("random() ASC")
  end

  def self.near(lat, lng, distance = 1000)
    closest(lat, lng).where "ST_DWithin(moments.coordinates, ST_MakePoint(#{lng.to_f}, #{lat.to_f}), #{distance.to_f})"
  end

  def self.closest(lat, lng)
    order "ST_Distance(moments.coordinates, ST_MakePoint(#{lng.to_f}, #{lat.to_f})) ASC"
  end

  def coordinates=(pair)
    if pair.is_a?(Array)
      pair = "POINT(#{pair[1].to_f} #{pair[0].to_f})"
    end
    write_attribute :coordinates, pair.presence
  end

  def formatted_timestamp
    return "unknown" if captured_at.blank?
    options = {year: captured_at.year, scope: :formatted_timestamp}
    if approximate_date?
      I18n.t :approximate, options
    else
      I18n.t :specific, options
    end
  end

  def image_size(name = :primary)
    ImageUploader.size_for width, height, name
  end

end

class Moment < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  belongs_to :landmark
  validates :image, :caption, :landmark,  presence: true
  # validates :image, integrity: true, processing: true

  def self.from_source(name, value)
    scope = where(external_key: name.to_s, external_identifier: value.to_s)
    scope.first || scope.build
  end

  def self.preloaded
    includes :landmark
  end

  def location=(value)
    self.landmark = (value.presence && Landmark.from_location(value))
  end
  delegate :location, to: :landmark, allow_nil: true

end

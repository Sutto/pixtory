class Moment < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  belongs_to :landmark
  validates :image, :caption, :landmark,  presence: true
  validates :image, integrity: true, processing: true

  def location=(value)
    self.landmark = (value.presence && Landmark.from_location(value))
  end
  delegate :location, to: :landmark, allow_nil: true

end

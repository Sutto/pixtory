class Moment < ActiveRecord::Base

  belongs_to :landmark
  validates  :image, :caption, :landmark,  presence: true

  def location=(value)
    # TODO: set landmark
    self.landmark = (value.presence && Location.from_location(value))
  end
  delegate :location, to: :landmark, allow_nil: true

end

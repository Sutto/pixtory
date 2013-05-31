class Landmark < ActiveRecord::Base

  validates :location, presence: true

  def self.near(location)
  end

  def self.from_location(location)
    where(location: location).first_or_create!
  end

  def location=(value)
    write_attribute :location, value
    geocode_location if value
  end

  def self.geocode(address)
    geocoded    =  GoogleMapsGeocoder.new address
    {
      city:        'Perth',
      coordinates: "POINT(#{geocoded.lng} #{geocoded.lat})",
      street:      geocoded.formatted_street_address.to_s.strip.presence,
      suburb:      geocoded.city
    }
  end

  protected

  def geocode_location
    return if location.blank? or coordinates.present?
    geocoded = self.class.geocode(location)
    self.attributes = geocoded if geocoded
  end

end

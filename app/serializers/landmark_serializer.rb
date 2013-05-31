class LandmarkSerializer < ActiveModel::Serializer

  attributes :id, :location, :city, :suburb, :street, :coordinates

  def coordinates
    coords = object.coordinates
    {
      lat: coords.lat,
      lng: coords.lon
    }
  end

end

class MomentSerializer < ActiveModel::Serializer

  attributes :id, :caption, :image, :formatted_timestamp, :source_url, :location, :description

  def image
    {
      full:    {url: object.image.url},
      primary: {url: object.image.url(:primary)},
      thumb:   {url: object.image.url(:thumb)}
    }
  end

  def location
    coords = object.coordinates
    {
      name: object.location,
      lat:  coords.lat,
      lng:  coords.lon
    }
  end

end

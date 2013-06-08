class MomentSerializer < ActiveModel::Serializer

  attributes :id, :caption, :image, :formatted_timestamp, :source_url, :location, :description, :source_name, :license, :source_image_url

  def image
    {
      full:    {url: object.image.url, width: object.width, height: object.height},
      primary: {url: object.image.url(:primary), width: 600, height: 300},
      thumb:   {url: object.image.url(:thumb), width: 300, height: 300}
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

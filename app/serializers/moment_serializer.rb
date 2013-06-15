class MomentSerializer < ActiveModel::Serializer

  attributes :id, :caption, :image, :formatted_timestamp, :source_url, :location,
             :description, :source_name, :license, :source_image_url,  :links

  def links
    controller = options[:controller]
    return {} if controller.blank?
    {
      :web     => controller.explore_moment_url(object),
      :self    => controller.moment_url(object, format: "json"),
      :geojson => controller.moment_url(object, format: "geojson"),
      :kml     => controller.moment_url(object, format: "kml")
    }
  end

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

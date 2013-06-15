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
    [:full, :primary, :thumb].each_with_object({}) do |v, images|
      images[v] = image_version(v)
    end
  end

  def location
    coords = object.coordinates
    {
      name: object.location,
      lat:  coords.lat,
      lng:  coords.lon
    }
  end

  private

  def image_version(name)
    url = (name == :full ? object.image.url : object.image.url(name))
    width, height = object.image_size name
    return {url: url, width: width, height: height}
  end

end

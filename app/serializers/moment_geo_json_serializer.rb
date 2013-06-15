class MomentGeoJsonSerializer < ActiveModel::Serializer

  attributes :type, :geometry, :properties

  alias moment object

  def self.collection(moments)
    {
      type:     'FeatureCollection',
      features: moments.map { |m| new(m).serializable_hash }
    }
  end

  def type
    "Feature"
  end

  def properties
    @properties ||= MomentSerializer.new(moment).serializable_hash
  end

  def geometry
    coords = moment.coordinates
    {
      type:        "Point",
      coordinates: [coords.lon, coords.lat]
    }
  end

end

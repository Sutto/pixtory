class MomentSerializer < ActiveModel::Serializer
  attributes :id, :caption, :image

  has_one :landmark

  def image
    {
      full:    {url: object.image.url},
      primary: {url: object.image.url(:primary)},
      thumb:   {url: object.image.url(:thumb)}
    }
  end

end

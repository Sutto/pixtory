class PersonSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar, :location,  :push_token, :authentication_token

  def include_push_token?
    options[:personal]
  end

  def include_authentication_token?
    options[:personal]
  end

end

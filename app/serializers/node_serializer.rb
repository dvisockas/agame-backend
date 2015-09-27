class NodeSerializer < ActiveModel::Serializer
  cached
  delegate :cache_key, to: :object

  attributes :position, :latitude, :longitude

end
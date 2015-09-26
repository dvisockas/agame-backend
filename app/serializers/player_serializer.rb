class PlayerSerializer < ActiveModel::Serializer

  attributes :id, :name, :latitude, :longitude

  has_many :estates, serializer: EstateSerializer
  has_many :player_resources, serializer: PlayerResourceSerializer

end
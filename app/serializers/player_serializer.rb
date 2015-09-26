class PlayerSerializer < ActiveModel::Serializer

  attributes :name, :latitude, :longitude

  has_many :estates, serializer: EstateSerializer

end
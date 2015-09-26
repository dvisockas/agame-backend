class PlayerSerializer < ActiveModel::Serializer

  attributes :id, :name, :latitude, :longitude, :gold

  has_many :estates, serializer: EstateSerializer

  def gold
    object.gold.amount
  end

end
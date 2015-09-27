class PlayerShowSerializer < ActiveModel::Serializer

  attributes :id, :name, :latitude, :longitude, :gold

  has_many :estates, serializer: PlayerEstateSerializer

  def gold
    object.gold.amount
  end

end
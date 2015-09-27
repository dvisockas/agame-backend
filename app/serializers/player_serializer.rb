class PlayerSerializer < ActiveModel::Serializer

  attributes :id, :name, :latitude, :longitude, :gold

  def gold
    object.gold.amount
  end

end
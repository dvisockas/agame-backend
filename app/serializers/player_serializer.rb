class PlayerSerializer < ActiveModel::Serializer

  attributes :id, :name, :latitude, :longitude, :gold

  has_one :gang

  def gold
    object.gold.amount
  end

  def gang
    object.gang
  end

end
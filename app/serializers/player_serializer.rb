class PlayerSerializer < ActiveModel::Serializer

  attributes :id, :name, :latitude, :longitude, :gold, :last_defeated, :last_defended

  has_one :gang

  def gold
    object.gold.amount
  end

  def gang
    object.gang
  end

end
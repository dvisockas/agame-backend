class EstateSerializer < ActiveModel::Serializer

  attributes  :id, :estate_type_id,
              :latitude, :longitude, :area,
              :name, :player

  has_many :nodes, serializer: NodeSerializer

  has_one :estate_type, serializer: EstateEstateTypeSerializer

  def player
    object.player
  end

  def area
    object.area.round 2
  end

  def estate_type
    object.estate_type
  end

end
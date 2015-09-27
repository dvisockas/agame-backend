class EstateSerializer < ActiveModel::Serializer

  attributes  :id, :estate_type_id,
              :latitude, :longitude, :area,
              :name, :player

  has_many :nodes, serializer: NodeSerializer

  def player
    object.player
  end

end
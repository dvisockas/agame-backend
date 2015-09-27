class EstateSerializer < ActiveModel::Serializer

  attributes  :id, :player_id, :estate_type_id,
              :latitude, :longitude, :area,
              :name#, :level

  has_many :nodes, serializer: NodeSerializer

end
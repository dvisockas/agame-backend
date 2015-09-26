class EstateSerializer < ActiveModel::Serializer

  attributes :id, :player_id, :latitude, :longitude, :estate_type_id, :health

end
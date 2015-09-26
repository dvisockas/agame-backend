class EstateSerializer < ActiveModel::Serializer

  attributes  :id, :player_id, :estate_type_id,
              :latitude, :longitude, :area,
              :name#, :level

end
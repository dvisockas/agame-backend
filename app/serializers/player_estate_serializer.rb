class PlayerEstateSerializer < ActiveModel::Serializer

  attributes  :id, :estate_type_id,
              :latitude, :longitude, :area,
              :name

  def area
    object.area.round 2
  end

end
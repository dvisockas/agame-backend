class PlayerEstateSerializer < ActiveModel::Serializer

  attributes  :id, :estate_type_id,
              :latitude, :longitude, :area,
              :name, :health, :resource_rate

  def area
    object.area.round 2
  end

  def health
    object.health.try :round, 2
  end

  def resource_rate
    object.resource_rate.try :round, 2
  end

end
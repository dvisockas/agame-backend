class EstateSerializer < ActiveModel::Serializer

  attributes :latitude, :longitude

  belongs_to :player

  def include_player?
    true
  end

end
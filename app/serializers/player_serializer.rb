class PlayerSerializer < ActiveModel::Serializer

  attributes :name, :latitude, :longitude

  has_many :estates

  def include_estates?
    true
  end

end
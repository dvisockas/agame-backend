class GameSerializer < ActiveModel::Serializer
  
  has_many :players
  has_many :estates

end
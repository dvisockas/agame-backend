class GameSerializer < ActiveModel::Serializers
  
  has_many :players
  has_many :estates

end
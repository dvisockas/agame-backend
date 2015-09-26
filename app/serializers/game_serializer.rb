class GameSerializer < ActiveModel::Serializer
  
  attributes :players, :estates

  def players
    object[:players].map do |player|
      PlayerSerializer.new(player).serializable_hash
    end
  end

  def estates
    object[:estates].map do |estate|
      EstateSerializer.new(estate).serializable_hash
    end
  end

end
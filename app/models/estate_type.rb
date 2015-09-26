class EstateType < ActiveRecord::Base

  enum kind: [:fortress, :main_resource, :main_storage]


  # class << self
  #   def build params
  #     player = Player.find_by id: params[:player_id]
  #     estate_type = EstateType.find_by id: params[:estate_type_id]

  #     if player.gold
  #   end
  # end

end
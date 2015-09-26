class Estate < ActiveRecord::Base

  belongs_to :player
  belongs_to :estate_type

  reverse_geocoded_by :latitude, :longitude

  def location
    [ latitude, longitude ]
  end

  def process params
    player = Player.find_by id: params[:player_id]
    _estate_type = EstateType.find_by id: params[:estate_type_id]
    
    if estate_type.blank?
      build player, _estate_type
    else
      upgrade player, _estate_type
    end
  
  end

  def upgrade player, _estate_type
    if player.can_afford?(_estate_type) && increment?(_estate_type)
      self.update _estate_type.build_options
      player.bill_gold _estate_type.cost
    end
  end

  def build player, _estate_type
    if player.can_afford?(_estate_type) && player.close_enough_to?(location)
      self.update _estate_type.build_options.merge(player_id: player.id)
      player.bill_gold _estate_type.cost
    end
  end

  def increment? _estate_type
    ( _estate_type.kind == estate_type.kind ) && ( _estate_type.level == (estate_type.level + 1) )
  end

end

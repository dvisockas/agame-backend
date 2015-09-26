class Estate < ActiveRecord::Base

  belongs_to :player
  belongs_to :estate_type

  reverse_geocoded_by :latitude, :longitude

  def upgrade
    player = Player.find_by id: params[:player_id]
    _estate_type = EstateType.find_by({ kind: estate_type.kind, level: (estate_type.level + 1) })

    if player.can_afford?(_estate_type)
      self.update _estate_type.build_options
      player.bill_gold _estate_type.cost
    else
      self
    end
  end

  class << self
    def build params
      player = Player.find_by id: params[:player_id]
      _estate_type = EstateType.find_by id: params[:estate_type_id]
      location = { latitude: params[:latitude], longitude: params[:longitude] }

      if player.can_afford?(_estate_type) && player.close_enough_to?(location)
        player.estates.create _estate_type.build_options.merge(location)
        player.bill_gold _estate_type.cost
      else
        nil
      end
    end

  end

end

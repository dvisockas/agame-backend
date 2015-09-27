class Estate < ActiveRecord::Base

  belongs_to :player
  belongs_to :estate_type
  has_many :nodes

  reverse_geocoded_by :latitude, :longitude

  def location
    [ latitude, longitude ]
  end

  def available_estates
    if estate_type.blank?
      EstateType.where({ level: 1 })
    else
      EstateType.where({ kind: estate_type.kind, level: (estate_type.level + 1) })
    end
  end

  def process params
    player = Player.find_by id: params[:player_id]
    _estate_type = EstateType.find_by id: params[:estate_type_id]

    if estate_type.blank?
      build player, _estate_type
    else
      upgrade _estate_type
    end
    self
  end

  def upgrade _estate_type
    if player.can_afford?(_estate_type) && increment?(_estate_type)
      self.update build_options(player, _estate_type)
      player.bill_gold _estate_type.cost
    end
  end

  def build _player, _estate_type
    byebug
    if _player.can_afford?(_estate_type) && _player.close_enough_to?(location)
      self.update build_options(_player, _estate_type)
      player.bill_gold _estate_type.cost
    end
  end

  def build_options _player, _estate_type
    _estate_type.build_options.merge({ player_id: _player.id, resource_rate: calculated_resource_rate * _estate_type.resource_rate })
  end

  def increment? _estate_type
    ( _estate_type.kind == estate_type.kind ) && ( _estate_type.level == (estate_type.level + 1) )
  end

  def calculated_health
    area * 10
  end

  def calculated_health_regen
    area * 0.5
  end

  def calculated_cost
    area * 10
  end

  def calculated_build_time
    area / 100
  end

  def calculated_resource_rate
    area * 5
  end

  def self.calculate_area points
    area = 0
    j = points.count - 1

    points.each_with_index do |p, i|
      area += (points[j][0] + p[0]) * (points[j][1] - p[1])
      j = i
    end

    area / 2
  end

end

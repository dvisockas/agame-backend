class Player < ActiveRecord::Base

  has_many :estates
  has_many :player_resources

  has_one :gold, lambda { gold }, class_name: 'PlayerResource'

  reverse_geocoded_by :latitude, :longitude
  after_create :allocate_resources, :set_name

  scope :gold, -> { player_resources.find_by kind: :gold }

  def can_afford? estate_type
    gold.amount >= estate_type.cost
  end

  def close_enough_to? location
    distance_from(location.values) <= 1.0
  end

  def bill_gold cost
    gold.update amount: (gold.amount - cost)
  end

private
  
  def allocate_resources
    self.player_resources.create({ kind: 0, amount: 1000 })
  end

end
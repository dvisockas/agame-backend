class Player < ActiveRecord::Base

  has_many :estates
  # has_many :player_resources

  # has_one :gold, lambda { gold }, class_name: 'PlayerResources'

  reverse_geocoded_by :latitude, :longitude

  after_save :set_name
  # after_create :allocate_resources

  scope :gold, -> { player_resources.find_by kind: :gold }

private
  
  def set_name
    self.class.where(id: id).update_all name: "#{name}-#{id}"
  end

  def allocate_resources
    self.player_resources.create({ kind: 0, amount: 1000 })
  end

end
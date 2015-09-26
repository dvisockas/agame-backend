class Player < ActiveRecord::Base

  has_many :estates

  reverse_geocoded_by :latitude, :longitude

  after_save :set_name

private
  
  def set_name
    self.class.where(id: id).update_all name: "#{name}-#{id}"
  end

end
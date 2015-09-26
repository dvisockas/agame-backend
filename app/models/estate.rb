class Estate < ActiveRecord::Base

  belongs_to :player
  belongs_to :estate_type

  reverse_geocoded_by :latitude, :longitude

end

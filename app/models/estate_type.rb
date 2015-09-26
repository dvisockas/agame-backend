class EstateType < ActiveRecord::Base

  enum kind: [:fortress, :main_resource, :main_storage]

  def self.build params
    
  end

end
class EstateType < ActiveRecord::Base

  enum kind: [:fortress, :main_resource, :main_storage]

  def build_options
    { estate_type_id: id, health: health }
  end

end
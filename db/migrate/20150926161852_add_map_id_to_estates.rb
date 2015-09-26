class AddMapIdToEstates < ActiveRecord::Migration
  def change
    add_column :estates, :map_id, :decimal
  end
end

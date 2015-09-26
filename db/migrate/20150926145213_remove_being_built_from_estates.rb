class RemoveBeingBuiltFromEstates < ActiveRecord::Migration
  def change
    remove_column :estates, :being_built, :boolean
    remove_column :estates, :level, :integer
    remove_column :estates, :max_health, :float
  end
end

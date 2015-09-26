class AddFieldsToEstatesAndEstateTypes < ActiveRecord::Migration
  def change
    add_column :estates, :health, :float
    add_column :estates, :max_health, :float
    add_column :estates, :level, :integer
    add_column :estates, :being_built, :boolean

    add_column :estate_types, :cost, :float
    add_column :estate_types, :health, :float
    add_column :estate_types, :health_regen, :float
    add_column :estate_types, :build_time, :float
    add_column :estate_types, :level, :integer
  end
end

class Whatever < ActiveRecord::Migration
  def change
    add_column :estates, :last_attacked_at, :datetime
    add_column :estates, :resource_rate, :float
    add_column :estate_types, :resource_rate, :float
  end
end

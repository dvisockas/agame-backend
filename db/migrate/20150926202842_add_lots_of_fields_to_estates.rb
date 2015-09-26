class AddLotsOfFieldsToEstates < ActiveRecord::Migration
  def change
    add_column :estates, :area, :float
    add_column :estates, :name, :string
  end
end

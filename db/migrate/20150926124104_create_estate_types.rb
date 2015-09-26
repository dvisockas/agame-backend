class CreateEstateTypes < ActiveRecord::Migration
  def change
    create_table :estate_types do |t|
      t.string :name

      t.timestamps
    end

    add_column :estates, :estate_type_id, :integer
    add_index :estates, :estate_type_id
  end
end

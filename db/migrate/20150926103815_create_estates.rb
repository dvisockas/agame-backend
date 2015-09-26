class CreateEstates < ActiveRecord::Migration
  def change
    create_table :estates do |t|
      t.float :latitude
      t.float :longitude

      t.integer :player_id

      t.timestamps
    end

    add_index :estates, :player_id
  end
end

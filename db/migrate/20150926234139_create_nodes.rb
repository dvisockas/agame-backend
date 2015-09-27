class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.integer :estate_id

      t.integer :position

      t.float :latitude
      t.float :longitude
    end
  end
end

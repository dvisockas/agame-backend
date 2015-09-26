class CreatePlayerResources < ActiveRecord::Migration
  def change
    create_table :player_resources do |t|
      t.integer :kind
      t.integer :player_id
      t.float :amount

      t.timestamps
    end

    add_index :player_resources, :player_id
  end
end

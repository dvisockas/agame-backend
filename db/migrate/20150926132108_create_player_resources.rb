class CreatePlayerResources < ActiveRecord::Migration
  def change
    create_table :player_resources do |t|
      t.integer :kind
      t.float :amount

      t.timestamps
    end
  end
end

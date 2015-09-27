class AddGangIdToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :gang_id, :integer
  end
end

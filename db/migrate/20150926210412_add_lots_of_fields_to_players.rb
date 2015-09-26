class AddLotsOfFieldsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :last_defeated, :datetime
    add_column :players, :last_defended, :datetime
  end
end

class AddKindToEstateTypes < ActiveRecord::Migration
  def change
    add_column :estate_types, :kind, :integer, null: false
  end
end

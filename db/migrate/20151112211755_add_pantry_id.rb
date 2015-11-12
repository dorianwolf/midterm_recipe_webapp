class AddPantryId < ActiveRecord::Migration
  def change
    add_column :pantries, :id, :primary_key
  end
end

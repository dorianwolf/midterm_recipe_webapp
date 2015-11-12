class RenamingPantry < ActiveRecord::Migration
  def change
    rename_table :pantry, :pantries
  end
end

class JoinInventoryRecipes < ActiveRecord::Migration
  def change
    create_join_table :inventory, :recipe, table_name: :ingredients
  end
end

class FixInventory < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :name
     end
     drop_table :inventory
     drop_table :ingredients
     create_join_table :inventories, :recipe, table_name: :ingredients
  end
end

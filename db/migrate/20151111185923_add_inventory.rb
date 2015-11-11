class AddInventory < ActiveRecord::Migration
  def change
    create_table :inventory do |t|
      t.string :name
     end
  end
end

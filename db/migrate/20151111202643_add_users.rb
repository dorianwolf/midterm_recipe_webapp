class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.timestamps null: false
    end
    create_join_table :users, :inventory, table_name: :pantry
  end
end

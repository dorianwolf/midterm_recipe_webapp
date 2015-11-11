class CreateRecipesTable < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :link
    end
  end
end

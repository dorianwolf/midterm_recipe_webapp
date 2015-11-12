class Ingredient < ActiveRecord::Base
  validates :inventory_id, :recipe_id, presence: true
end

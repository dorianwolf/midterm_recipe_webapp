class Ingredient < ActiveRecord::Base
  validates :inventory_id, :recipe_id, presence: true
  belongs_to :recipe
  belongs_to :inventory
end

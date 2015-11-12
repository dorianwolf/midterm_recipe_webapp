require 'rubygems'
require 'bundler/setup'

require 'active_support/all'

require 'active_record'
require 'faker'

require './app/models/inventory'
require './app/models/recipe'

require './config/environment'
require './config/database'

# def add_ingredient(ingredient_name, recipe_name)
#   addition = Ingredient.new(
#   inventory_id: Inventory.find_by(name: ingredient_name).id,
#   recipe_id: Recipe.find_by(name: recipe_name).id
#   )
#   addition.save
# end
#
# inventory_carbs = ["bread", "rice", "wheat", "flour"]
#
# inventory_vegetables = ["potatos", "onions", "garlic", "ginger", "lettuce", "kale", "mushrooms", "corn"]
#
# inventory_fruits = ["mangoes", "oranges", "grapes", "pineapples", "bananas", "apples"]
#
# inventory_proteins = ["beef", "pork", "chicken", "turkey", "eggs", "milk", "beans"]
#
# inventory_carbs.each do |carb|
#   Inventory.create!(
#     name: carb
#   )
# end
#
# inventory_vegetables.each do |veggies|
#   Inventory.create!(
#     name: veggies
#   )
# end
#
# inventory_fruits.each do |fruit|
#   Inventory.create(name: fruit)
# end
#
# inventory_proteins.each do |protein|
#   Inventory.create(name: protein)
# end

@recipe1 =  Recipe.create(
    name: Faker::Book.title,
    link: Faker::Internet.url('howtocook.com')
    )

@item1 =  Inventory.create(name: Faker::Book.title)
@item2 =  Inventory.create(name: Faker::Book.title)
@item3 =  Inventory.create(name: Faker::Book.title)

Ingredient.create(recipe_id: @recipe1.id, inventory_id: @item1.id)
Ingredient.create(recipe_id: @recipe1.id, inventory_id: @item2.id)
Ingredient.create(recipe_id: @recipe1.id, inventory_id: @item3.id)

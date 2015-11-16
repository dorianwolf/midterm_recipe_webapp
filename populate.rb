require 'rubygems'
require 'bundler/setup'

require 'active_support/all'

require 'active_record'
require 'faker'

require './app/models/inventory'
require './app/models/recipe'

require './config/environment'
require './config/database'


def add_ingredient(ingredient_name, recipe)
  addition = Ingredient.create(
  inventory_id: Inventory.find_by(name: ingredient_name).id,
  recipe_id: recipe.id
  )
end

def add_recipe(name, link, ingredients)
  recipe = Recipe.create(
  name: name,
  link: link
  )
  ingredients.each do |ingredient|
    add_ingredient(ingredient, recipe)
  end

end


inventory_carbs = ["bread", "rice", "wheat", "flour"]

inventory_vegetables = ["potatos", "onions", "garlic", "ginger", "lettuce", "kale", "mushrooms", "corn", "carrots"]

inventory_fruits = ["mangoes", "oranges", "grapes", "pineapples", "bananas", "apples", "tomatoes", "lemons", "limes"]

inventory_proteins = ["beef", "pork", "chicken", "turkey", "eggs", "milk", "beans"]

inventory_carbs.each do |carb|
  Inventory.create(
    name: carb
  )
end

inventory_vegetables.each do |veggies|
  Inventory.create(
    name: veggies
  )
end

inventory_fruits.each do |fruit|
  Inventory.create(
    name: fruit
  )
end

inventory_proteins.each do |protein|
  Inventory.create(
    name: protein
  )
end

add_recipe("A Sandwich", "https://www.youtube.com/watch?v=URvWSsAgtJE", ['bread'])
add_recipe("Breakfast", "http://www.jamieoliver.com/recipes/eggs-recipes/baked-eggs-lots-of-ways/#yVb19UTiEFbJ8qxD.97", ["eggs", "bread"])
add_recipe("An Old Skool Meatball Sub", "http://www.jamieoliver.com/videos/gennaro-s-italian-meatball-sub-ft-jamie-oliver/#rQf0iAHGr9IXP8Fz.97", ["tomatoes", "bread", "beef", "eggs"])
add_recipe("A Traditional Irish Stew", "https://www.youtube.com/watch?v=URvWSsAgtJE", ["potatos", "onions", "beef", "carrots"])
add_recipe("Grilled Chicken Salad", "http://www.cookstr.com/recipes/grilled-chicken-salad", ["lettuce", "chicken", "garlic", "limes", "onions"])
add_recipe("Some Untraditional Stew", "#", ['potatos', 'garlic', 'mushrooms', 'tomatoes', 'mangoes' ])
add_recipe("Orange Juice", "#", ['oranges'])
add_recipe("A Turkey Burger", "#", ['turkey', 'onions', 'tomatoes', 'lettuce', 'bread'])

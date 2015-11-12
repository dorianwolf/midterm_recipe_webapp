require 'rubygems'
require 'bundler/setup'

require 'active_support/all'

require 'active_record'
require 'faker'

require './app/models/inventory'
require './app/models/recipe'

require './config/environment'
require './config/database'

inventory_carbs = ["bread", "rice", "wheat", "flour"]

inventory_vegetables = ["potatos", "onions", "garlic", "ginger", "lettuce", "kale", "mushrooms", "corn"]

inventory_fruits = ["mangoes", "oranges", "grapes", "pineapples", "bananas", "apples"]

inventory_proteins = ["beef", "pork", "chicken", "turkey", "eggs", "milk", "beans"]

inventory_carbs.each do |carb|
  Inventory.create!(
    name: carb
  )
end

inventory_vegetables.each do |veggies|
  Inventory.create!(
    name: veggies
  )
end

inventory_fruits.each do |fruit|
  Inventory.create!(
    name: fruit
  )
end

inventory_proteins.each do |protein|
  Inventory.create!(
    name: protein
  )
end

3.times do
  Recipe.create!(
    name: Faker::Book.title,
    link: Faker::Internet.url('howtocook.com')
  )
end

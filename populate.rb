require 'rubygems'
require 'bundler/setup'

require 'active_support/all'

require 'active_record'
require 'faker'

require './app/models/inventory'
require './app/models/recipe'

require './config/environment'
require './config/database'

9.times do
  Inventory.create!(
    name: Faker::Name.name
  )
end

3.times do
  Recipe.create!(
    name: Faker::Book.title,
    link: Faker::Internet.url('howtocook.com')
  )
end

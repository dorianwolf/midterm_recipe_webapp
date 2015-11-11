class Recipe < ActiveRecord::Migration
  validates :name, :link, presence: true
  validates :name, uniqueness: true, length: { maximum: 40 }
end

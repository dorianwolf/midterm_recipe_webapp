class Recipe < ActiveRecord::Base
  validates :name, :link, presence: true
  validates :name, uniqueness: true, length: { maximum: 40 }
  has_many :ingredients
end

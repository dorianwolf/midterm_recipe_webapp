class Inventory < ActiveRecord::Base
  belongs_to :pantry
  validates :name, presence: true, length: { maximum: 40 }, uniqueness: true
end

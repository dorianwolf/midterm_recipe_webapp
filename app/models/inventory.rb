class Inventory < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 40 }, uniqueness: true
  belongs_to :pantry
end

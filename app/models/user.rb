class User < ActiveRecord::Base
  belongs_to :pantry
  has_many :inventories, through: :pantries
  validates :username, presence: true, length: { maximum: 40 }
  has_secure_password
end

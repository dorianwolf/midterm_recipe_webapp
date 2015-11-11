class User < ActiveRecord::Base
  validates :username, :password, presence: true, uniqueness: true, length: { maximum: 40 }
  has_secure_password
end

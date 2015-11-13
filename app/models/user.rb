class User < ActiveRecord::Base
  validates :username, presence: true, length: { maximum: 40 }
  has_secure_password
end

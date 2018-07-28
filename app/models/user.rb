class User < ApplicationRecord
  has_secure_password
  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true
  has_many :clients
  has_many :shipments
end
require 'pry'
class User < ApplicationRecord
  has_secure_password
  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true
  has_many :clients
  has_many :shipments

  def items
    user_items = []
    self.clients.each do |client|
      client.items.each {|item| user_items << item}
    end
    user_items
  end
end

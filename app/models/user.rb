require 'pry'
class User < ApplicationRecord
  has_secure_password
  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true
  has_many :clients
  has_many :shipments
  has_many :drivers
  has_many :locations
  has_many :shipment_details, through: :shipments

  scope :active_users, -> {joins(:shipments).group(:user_id).order('COUNT(user_id) DESC').having('COUNT(user_id) >= 5')}

  def items
    user_items = []
    self.clients.each do |client|
      client.items.each {|item| user_items << item}
    end
    user_items
  end

  def self.find_or_create_by_omniauth(auth_hash)
    user_email = auth_hash[:info][:email]
    if user = User.find_by(email: user_email)
      return user
    else
      user_name = auth_hash[:info][:name]
      user = User.create(username: user_name, email: user_email, password: SecureRandom.hex)
    end
  end
end

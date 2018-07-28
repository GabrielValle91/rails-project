class Shipment < ApplicationRecord
  validates :pickup_date, :delivery_date, presence: true
  has_many :shipment_items
  has_many :items, through: :shipment_items
  has_many :shipment_drivers
  has_many :drivers, through: :shipment_drivers
  has_many :shipment_locations
  has_many :locations, through: :shipment_locations
  belongs_to :user
  belongs_to :client
end

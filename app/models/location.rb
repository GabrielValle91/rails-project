class Location < ApplicationRecord
  has_many :shipment_locations
  has_many :shipments, through: :shipment_locations
  has_many :shipment_drivers, through: :shipment_locations
  has_many :drivers, through: :shipment_drivers
end

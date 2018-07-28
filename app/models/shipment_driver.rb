class ShipmentDriver < ApplicationRecord
  belongs_to :shipment
  belongs_to :driver
  has_and_belongs_to_many :shipment_locations
end

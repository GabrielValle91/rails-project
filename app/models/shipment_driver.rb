class ShipmentDriver < ApplicationRecord
  belongs_to :shipment
  belongs_to :driver
end

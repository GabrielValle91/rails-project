class ShipmentDetail < ApplicationRecord
  belongs_to :shipment
  belongs_to :driver, optional: true
  belongs_to :location, optional: true
end

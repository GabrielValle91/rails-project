class ShipmentLocation < ApplicationRecord
  validates :location_type, presence: true
  belongs_to :shipment
  belongs_to :location
end

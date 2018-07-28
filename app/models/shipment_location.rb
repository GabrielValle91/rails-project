class ShipmentLocation < ApplicationRecord
  validates :location_type, presence: true
  belongs_to :shipment
  has_and_belongs_to_many :shipment_drivers
  belongs_to :location
end

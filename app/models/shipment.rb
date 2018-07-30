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

  def location_shipper=(hash_details)
    if hash_details[:id]
      ShipmentLocation.create(shipment_id: self.id, location_id: hash_details[:id], location_type: "shipper")
    else

    end
  end

  def location_consignee=(hash_details)

  end
end

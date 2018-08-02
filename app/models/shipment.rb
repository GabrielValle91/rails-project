class Shipment < ApplicationRecord
  validates :pickup_date, :delivery_date, presence: true
  has_many :shipment_items
  has_many :items, through: :shipment_items
  has_many :shipment_details
  has_many :drivers, through: :shipment_details
  has_many :locations, through: :shipment_details
  belongs_to :user
  belongs_to :client

  def client_name=(name)
    self.client = Client.find_by(name: name, user_id: self.user_id)
  end

  def location_shipper=(hash_details)
    if self.id
      new_detail = ShipmentDetail.find_or_create_by(shipment_id: self.id, location_type: "shipper")
      new_detail.location_id = hash_details[:id]
      new_detail.driver_id = hash_details[:driver_id]
      new_detail.save
    end
  end

  def location_consignee=(hash_details)
    if self.id
      new_detail = ShipmentDetail.find_or_create_by(shipment_id: self.id, location_type: "consignee")
      new_detail.location_id = hash_details[:id]
      new_detail.driver_id = hash_details[:driver_id]
      new_detail.save
    end
  end
end

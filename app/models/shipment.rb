class Shipment < ApplicationRecord
  validates :pickup_date, :delivery_date, presence: true
  has_many :shipment_items
  has_many :items, through: :shipment_items
  has_many :shipment_details
  has_many :drivers, through: :shipment_details
  has_many :locations, through: :shipment_details
  belongs_to :user
  belongs_to :client

  before_validation :set_user

  def client_name=(name)
    self.client = Client.find_by(name: name, user_id: self.user_id)
  end

  def driver=(hash_details)
    if hash_details[:id].first
      ShipmentDriver.create(shipment_id: self.id, driver_id: hash_details[:id].first, driver_type: "shipper")
    end
    if hash_details[:id].last
      ShipmentDriver.create(shipment_id: self.id, driver_id: hash_details[:id].first, driver_type: "consignee")
    end
  end

  def location_shipper=(hash_details)
    if hash_details[:id]
      ShipmentLocation.create(shipment_id: self.id, location_id: hash_details[:id], location_type: "shipper")
    else
      new_loc = Location.new(company_name: hash_details[:company_name], address1: hash_details[:address1], address2: hash_details[:address2], city: hash_details[:city], state: hash_details[:state], zip_code: hash_details[:zip_code])
      if new_loc.save
        ShipmentLocation.create(shipment_id: self.id, location_id: new_loc.id, location_type: "consignee")
      else
        return new_loc.errors
      end
    end
  end

  def location_consignee=(hash_details)
    if hash_details[:id]
      ShipmentLocation.create(shipment_id: self.id, location_id: hash_details[:id], location_type: "consignee")
    else
      new_loc = Location.new(company_name: hash_details[:company_name], address1: hash_details[:address1], address2: hash_details[:address2], city: hash_details[:city], state: hash_details[:state], zip_code: hash_details[:zip_code])
      if new_loc.save
        ShipmentLocation.create(shipment_id: self.id, location_id: new_loc.id, location_type: "consignee")
      else
        return new_loc.errors
      end
    end
  end

  private

  def set_user
    self.user_id = self.client.user_id
  end
end

class Shipment < ApplicationRecord
  validates :pickup_date, :delivery_date, presence: true
  has_many :shipment_items
  has_many :items, through: :shipment_items
  has_many :shipment_details
  has_many :drivers, through: :shipment_details
  has_many :locations, through: :shipment_details
  belongs_to :user
  belongs_to :client

  scope :today_shipments, -> { where('pickup_date = ? Or delivery_date = ?', Date.today, Date.today)}

  scope :unassigned_shipments, -> { joins(:shipment_details).where('shipment_details.driver_id is null')}

  def client_name=(name)
    self.client = Client.find_by(name: name, user_id: self.user_id)
  end

  def location_shipper=(hash_details)
    if self.id
      new_detail = new_shipment_detail(hash_details, "shipper")
      if hash_details[:company_name]
        new_location(new_detail, hash_details)
      end
      new_detail.save
    end
  end

  def location_consignee=(hash_details)
    if self.id
      new_detail = new_shipment_detail(hash_details, "consignee")
      if hash_details[:company_name]
        new_location(new_detail, hash_details)
      end
      new_detail.save
    end
  end

  def new_shipment_detail(shipment_details, location_type)
    new_detail = ShipmentDetail.find_or_create_by(shipment_id: self.id, location_type: "#{location_type}")
    new_detail.location_id = shipment_details[:id]
    new_detail.driver_id = shipment_details[:driver_id]
    new_detail
  end

  def new_location(shipment_detail, location_details)
    new_loc = Location.new
    new_loc.company_name = location_details[:company_name]
    new_loc.address1 = location_details[:address1]
    new_loc.address2 = location_details[:address2]
    new_loc.city = location_details[:city]
    new_loc.state = location_details[:state]
    new_loc.zip_code = location_details[:zip_code]
    new_loc.user = self.user
    if new_loc.save
      shipment_detail.location_id = new_loc.id
    end
  end
end

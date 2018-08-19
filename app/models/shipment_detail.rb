class ShipmentDetail < ApplicationRecord
  belongs_to :shipment
  belongs_to :driver, optional: true
  belongs_to :location, optional: true

  scope :shipper, -> { joins(:location).where(location_type: "shipper").limit(1).first}

  scope :pickup_driver, -> { joins(:driver).where(location_type: "shipper").limit(1).first}

  scope :consignee, -> {joins(:location).where(location_type: "consignee").limit(1).first}

  scope :delivery_driver, -> { joins(:driver).where(location_type: "consignee").limit(1).first}

  scope :unassigned_shipments, -> { where(:driver_id => nil)}
end

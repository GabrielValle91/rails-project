class shipmentDetail < ApplicationRecord
  belongs_to :shipment
  belongs_to :driver
  belongs_to :location
end

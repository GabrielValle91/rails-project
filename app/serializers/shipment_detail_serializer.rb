class ShipmentDetailSerializer < ActiveModel::Serializer
  attributes :id, :shipment_id, :driver_id, :location_id, :location_type
  belongs_to :shipment
  belongs_to :driver
  belongs_to :location
end

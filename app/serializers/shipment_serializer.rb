class ShipmentSerializer < ActiveModel::Serializer
  attributes :id, :reference, :pickup_date, :delivery_date, :status
  has_many :shipment_details
end

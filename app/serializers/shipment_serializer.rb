class ShipmentSerializer < ActiveModel::Serializer
  attributes :id, :reference, :pickup_date, :delivery_date, :status
  belongs_to :client
  has_many :shipment_details
end

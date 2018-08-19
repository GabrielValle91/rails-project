class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :shipments
end

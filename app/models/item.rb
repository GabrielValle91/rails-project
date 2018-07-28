class Item < ApplicationRecord
  validates :name, presence: true
  belongs_to :client
  has_many :shipment_items
  has_many :shipments, through: :shipment_items
end

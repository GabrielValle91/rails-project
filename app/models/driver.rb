class Driver < ApplicationRecord
  validates :name, :license, :driver_type, presence: true
  has_many :shipment_drivers
  has_many :shipments, through: :shipment_drivers
  belongs_to :user

  LICENSES = ["Class A", "Class C"]
  DRIVERTYPES = ["Employee", "Owner Operator"]
end

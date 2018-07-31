class Driver < ApplicationRecord
  validates :name, :license, :driver_type, presence: true
  has_many :shipment_details
  has_many :shipments, through: :shipment_details
  belongs_to :user

  LICENSES = ["Class A", "Class C"]
  DRIVERTYPES = ["Employee", "Owner Operator"]
end

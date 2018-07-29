class Location < ApplicationRecord
  STATES = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME",
    "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI",
    "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
  has_many :shipment_locations
  has_many :shipments, through: :shipment_locations
  has_many :shipment_drivers, through: :shipment_locations
  has_many :drivers, through: :shipment_drivers
  validates :company_name, :address1, :city, :state, :zip_code, presence: true
end

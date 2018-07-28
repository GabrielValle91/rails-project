class Client < ApplicationRecord
  validates :name, presence: true
  has_many :shipments
  has_many :items
  belongs_to :user
end

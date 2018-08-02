class Client < ApplicationRecord
  validates :name, presence: true
  has_many :shipments
  has_many :items
  belongs_to :user

  scope :top_5, -> { joins(:shipments).group(:client_id).order('COUNT(client_id) DESC').limit(5)}

  scope :active, -> { where(status: true)}
end

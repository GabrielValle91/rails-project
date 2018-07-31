class CreateShipmentDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :shipment_details do |t|
      t.belongs_to :shipment
      t.belongs_to :driver
      t.belongs_to :location
      t.string :location_type
    end
  end
end

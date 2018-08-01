class CreateShipmentDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :shipment_details do |t|
      t.belongs_to :shipment
      t.belongs_to :driver, default: 1
      t.belongs_to :location, default: 1
      t.string :location_type
    end
  end
end

class CreateJoinTableShipmentDrivers < ActiveRecord::Migration[5.2]
  def change
    create_table :shipment_drivers do |t|
      t.belongs_to :shipment
      t.belongs_to :driver
      t.belongs_to :shipment_location
      t.timestamps
    end
  end
end

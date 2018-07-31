class DropShipmentDrivers < ActiveRecord::Migration[5.2]
  def change
    drop_table :shipment_drivers
  end
end

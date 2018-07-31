class DropShipmentLocations < ActiveRecord::Migration[5.2]
  def change
    drop_table :shipment_locations
  end
end

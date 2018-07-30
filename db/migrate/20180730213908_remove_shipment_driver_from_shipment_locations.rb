class RemoveShipmentDriverFromShipmentLocations < ActiveRecord::Migration[5.2]
  def change
    remove_column :shipment_locations, :shipment_driver_id
  end
end

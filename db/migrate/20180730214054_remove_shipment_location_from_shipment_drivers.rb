class RemoveShipmentLocationFromShipmentDrivers < ActiveRecord::Migration[5.2]
  def change
    remove_column :shipment_drivers, :shipment_location_id
  end
end

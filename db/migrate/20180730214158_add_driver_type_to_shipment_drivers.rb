class AddDriverTypeToShipmentDrivers < ActiveRecord::Migration[5.2]
  def change
    add_column :shipment_drivers :driver_type, :integer
  end
end

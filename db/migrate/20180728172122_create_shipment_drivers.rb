class CreateShipmentDrivers < ActiveRecord::Migration[5.2]
  def change
    create_table :shipment_drivers do |t|

      t.timestamps
    end
  end
end

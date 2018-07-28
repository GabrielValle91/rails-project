class CreateShipmentLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :shipment_locations do |t|

      t.timestamps
    end
  end
end

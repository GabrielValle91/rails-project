class CreateJoinTableShipmentLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :shipment_locations do |t|
      t.belongs_to :shipment
      t.belongs_to :location
      t.belongs_to :shipment_driver
      t.string :location_type
      t.timestamps
    end
  end
end

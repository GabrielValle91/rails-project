class CreateJoinTableShipmentLocations < ActiveRecord::Migration[5.2]
  def change
    create_join_table :shipments, :locations do |t|
      # t.index [:shipment_id, :location_id]
      # t.index [:location_id, :shipment_id]
    end
  end
end

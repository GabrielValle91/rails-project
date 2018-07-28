class CreateJoinTableShipmentDrivers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :shipments, :drivers do |t|
      # t.index [:shipment_id, :driver_id]
      # t.index [:driver_id, :shipment_id]
    end
  end
end

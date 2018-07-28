class CreateJoinTableShipmentItems < ActiveRecord::Migration[5.2]
  def change
    create_join_table :shipments, :items do |t|
      # t.index [:shipment_id, :item_id]
      # t.index [:item_id, :shipment_id]
    end
  end
end

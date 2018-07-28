class CreateJoinTableShipmentItems < ActiveRecord::Migration[5.2]
  def change
    create_table :shipment_items do |t|
      t.belongs_to :shipment
      t.belongs_to :item
      t.integer :quantity
      t.string :item_type
      t.timestamps
    end
  end
end

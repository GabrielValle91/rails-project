class ChangeColumnDefaultForShipmentDetails < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:shipment_details, :location_id, nil)
    change_column_default(:shipment_details, :driver_id, nil)
  end
end

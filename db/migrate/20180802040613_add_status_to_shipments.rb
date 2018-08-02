class AddStatusToShipments < ActiveRecord::Migration[5.2]
  def change
    add_column :shipments, :status, :string, default: "open"
  end
end

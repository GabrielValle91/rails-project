class AddClientIdToShipments < ActiveRecord::Migration[5.2]
  def change
    add_column :shipments, :client_id, :integer
  end
end

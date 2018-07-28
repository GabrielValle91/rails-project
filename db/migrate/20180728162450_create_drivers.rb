class CreateDrivers < ActiveRecord::Migration[5.2]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :license
      t.string :driver_type
      t.timestamps
    end
  end
end

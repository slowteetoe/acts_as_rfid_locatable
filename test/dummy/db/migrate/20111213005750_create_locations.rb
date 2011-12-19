class CreateLocations < ActiveRecord::Migration
  def change
    create_table :asset_locations do |t|
      t.string :description
      t.string :rfid_tag

      t.timestamps
    end
  end
end

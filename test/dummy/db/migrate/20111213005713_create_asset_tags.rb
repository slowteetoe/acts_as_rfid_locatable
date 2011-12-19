class CreateAssetTags < ActiveRecord::Migration
  def change
    create_table :asset_tags do |t|
      t.string :uuid
      t.string :asset_type
      t.string :asset_id
      t.string :asset_location_id

      t.timestamps
    end
  end
end

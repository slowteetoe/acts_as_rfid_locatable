# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

AssetLocation.destroy_all

AssetLocation.create!(
  :description => 'Left shelf',
  :rfid_tag => '84003380DE'
)
AssetLocation.create!(
  :description => 'Right shelf',
  :rfid_tag => '8400337E7A'
)



#create_table "asset_tags", :force => true do |t|
#  t.string   "uuid"
#  t.string   "asset_type"
#  t.string   "asset_id"
#  t.string   "asset_location_id"
#  t.datetime "created_at"
#  t.datetime "updated_at"
#end
AssetTag.destroy_all

AssetTag.create!(
  :uuid => '8400337CAA'
)
AssetTag.create!(
  :uuid => '8400337CBD'
)
AssetTag.create!(
  :uuid => '84003377D6'
)
AssetTag.create!(
  :uuid => '8400337E7A'
)
AssetTag.create!(
  :uuid => '84003381D3'
)

# Create some dummy book data to assign the tags to and make more meaningful
#create_table "books", :force => true do |t|
#  t.string   "title"
#  t.datetime "created_at"
#  t.datetime "updated_at"
#end

Book.destroy_all

Book.create!(
  :title => "RFID for Dummies"
)
Book.create!(
  :title => "Programming for Dummies"
)
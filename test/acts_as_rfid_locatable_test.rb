require 'test_helper'

class ActsAsRfidLocatableTest < ActiveSupport::TestCase

  test "should create an asset tag" do
    uuid = "deadbeef"
    a = AssetTag.new(:uuid => uuid)
    assert a.save
    assert_equal(uuid, a.uuid)
  end
  
  test "should require a uuid to create asset tag" do
    a = AssetTag.new
    assert !a.save, "should have required a UUID"
  end
 
  # test "should assign unique tag to book" do
  #   uuid = "deadbeef"
  #   b = Book.new
  #   b.asset_tag = "deadbeef"
  #   b.save
  #   actual = Book.find_by_uuid(uuid)
  #   assert_same b, actual
  # end
  
end

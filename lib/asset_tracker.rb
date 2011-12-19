require "sinatra/base"
require 'json'
require 'pp'

class AssetTracker < Sinatra::Base
  set :root, File.dirname(__FILE__)

  post "/trackAssets" do
    data = JSON.parse(request.body.read)
   "Thank you for your submission, #{data["tokens"]} will be associated with location #{data["location_identifier"]}"
   resp = AssetTag.assign_uuids_to_asset_location(data["tokens"], data["location_identifier"])
   resp.to_json
  end

  get "/trackAssets" do
    known_locations = []
    AssetLocation.find( :all ).each do |location|
      known_locations << location.description
    end
    "Please refer to the installation instructions.  You should be posting JSON data to this URI. #{known_locations}"
  end

  run! if __FILE__ == $0
end

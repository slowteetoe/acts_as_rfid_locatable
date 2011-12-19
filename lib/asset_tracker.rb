require "sinatra/base"
require 'json'
require 'pp'

class AssetTracker < Sinatra::Base
  set :root, File.dirname(__FILE__)

  post "/trackAssets" do
    data = JSON.parse(request.body.read)
    resp = AssetTag.assign_uuids_to_asset_location(data["tokens"], data["location_identifier"])
    resp.to_json
  end

  get "/trackAssets" do
    "Please refer to the installation instructions.  You should be posting JSON data to this URI."
  end

  run! if __FILE__ == $0
end

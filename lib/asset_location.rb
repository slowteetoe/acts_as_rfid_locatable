class AssetLocation < ActiveRecord::Base
  has_many :asset_tags
end

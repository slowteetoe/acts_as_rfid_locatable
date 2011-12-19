class AssetTag < ActiveRecord::Base
  belongs_to :asset, :polymorphic => true
  belongs_to :asset_location, :autosave => true
  validates_presence_of :uuid
end

module ActsAsRfidLocatable
  extend ActiveSupport::Concern

  require 'asset_location.rb'
  require 'asset_tag.rb'

  included do
  end

  module ClassMethods
    def acts_as_rfid_locatable(options={})
      belongs_to :asset_location
    end

    def current_location_for_uuid(uuid='')
      AssetTag.find_by_uuid(uuid).asset_location
    end

    def assign_uuids_to_asset_location(uuids=[], asset_location_id)
      not_found = []
      successful = []
      removed = []
      l = AssetLocation.find_by_rfid_tag( asset_location_id )
      if l.nil?
        return "Unknown location (#{asset_location_id})!!!"
      end
      original_contents = l.asset_tags.collect {|x| x.uuid}
      uuids.each do |uuid|
        logger.info("Assigning UUID(#{uuid}) to asset_location #{asset_location_id}...")
        tag = AssetTag.find_by_uuid uuid
        if tag.nil?
          not_found << uuid
        else
          tag.asset_location_id = l.id
          tag.save!
          logger.info("Assigned UUID(#{uuid}) to asset_location #{asset_location_id}.")
          successful << uuid
        end
      end
      removed = original_contents - successful
      removed.each do |uuid|
        tag = AssetTag.find_by_uuid(uuid)
        tag.asset_location_id = nil
        tag.save!
      end
      {:original_contents => original_contents, :not_found => not_found, :successful => successful, :removed => removed}
    end
  end

  def asset_tag=(uuid=nil)
    logger.info("Trying to assign #{uuid} to #{self}")

    tag_for_uuid = AssetTag.find_by_uuid( uuid )
    existing_tag = AssetTag.find_by_asset_type_and_asset_id( self.class.name, self.id)

    raise "That UUID(#{uuid}) is already assigned to a different asset." unless tag_for_uuid.nil? or tag_for_uuid.id == existing_tag.id

    if existing_tag.nil?
      existing_tag = AssetTag.new
      existing_tag.asset = self
    end
    existing_tag.uuid = uuid
    existing_tag.save
    logger.info("Saved #{existing_tag}")
    existing_tag
  end

  def asset_tag
    AssetTag.find_by_asset_type_and_asset_id( self.class.name, self.id)
  end

end

ActiveRecord::Base.send :include, ActsAsRfidLocatable
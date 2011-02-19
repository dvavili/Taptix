class AddLongitudeToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :lng, :number
  end

  def self.down
    remove_column :events, :lng
  end
end

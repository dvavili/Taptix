class AddLatitudeToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :lat, :number
  end

  def self.down
    remove_column :events, :lat
  end
end

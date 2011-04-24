class AddExtraInformationToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :extra, :string
  end

  def self.down
    remove_column :events, :extra
  end
end

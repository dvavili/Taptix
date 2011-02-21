class ChangeColumn < ActiveRecord::Migration
  def self.up
    change_column :events, :description, :text
  end

  def self.down
  end
end

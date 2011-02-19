class AddNumberOfHitsToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :number_of_hits, :integer
  end

  def self.down
    remove_column :events, :number_of_hits
  end
end

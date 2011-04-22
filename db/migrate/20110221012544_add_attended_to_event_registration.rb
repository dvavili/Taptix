class AddAttendedToEventRegistration < ActiveRecord::Migration
  def self.up
    add_column :event_registrations, :attended, :integer
  end

  def self.down
    remove_column :event_registrations, :attended
  end
end

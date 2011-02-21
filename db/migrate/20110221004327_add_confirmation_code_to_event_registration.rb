class AddConfirmationCodeToEventRegistration < ActiveRecord::Migration
  def self.up
    add_column :event_registrations, :confirmation, :string
  end

  def self.down
    remove_column :event_registrations, :confirmation
  end
end

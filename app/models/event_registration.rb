require 'digest/sha1' 

class EventRegistration < ActiveRecord::Base
  belongs_to :event, :foreign_key=>'event_id'
  before_create :create_confirmation_code

  def create_confirmation_code
    self.confirmation = Digest::SHA1.hexdigest("$--#{self.event_id}--$--#{self.application_id}--$--#{self.created_at}--$")
  end
end

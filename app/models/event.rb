include Geokit::Geocoders

class Event < ActiveRecord::Base
  @photo_path = "/assets/events/:id/:style/:basename.:extension"
  belongs_to :user
  has_many :registrations

  validate :price_must_be_atleast_a_cent
  validate :validate_fields
  validate :geocode_address

  acts_as_mappable :lat_column_name => :lat, :lng_column_namr => :lng
  
  def self.find_all_events 
    Event.find(:all, :order=>"date asc", :conditions=>['date > ?',Date.today])
  end

  def self.find_user_events(user_id)
    Event.find(:all, :order=>"date asc", :conditions=>['date > ? and user_id = ?',Date.today,user_id])
  end

  def self.search_categories(event_category, address)
    events = Event.find(:all, :order=>"date asc", :conditions=>["date > ? and category ~* '#{event_category}'",Date.today])
    #    user_loc = Geokit::Geocoders::GoogleGeocoder.reverse_geocode "#{latitude},#{longitude}"
    user_loc = Geokit::Geocoders::MultiGeocoder.geocode(address)
    events.sort_by_distance_from(user_loc)
    events.to_json()
  end


  def self.search_events(event_title)
    #    Event.find(:all, :order=>"date asc", :conditions=>["date > ? and (title like '%#{event_title}%' or description like '%#{event_title}%' or address like '%#{event_title}%' or category like '%#{event_title}%')",Date.today])
    Event.find(:all, :order=>"date asc", :conditions=>["date > ? and (title ~* '#{event_title}' or description ~* '#{event_title}' or address ~* '#{event_title}' or category ~* '#{event_title}')",Date.today])
  end

  def self.search_relevant_events(event_title, address)
    events = Event.find(:all, :order=>"date asc", :conditions=>["date > ? and (title ~* '#{event_title}' or description ~* '#{event_title}' or address ~* '#{event_title}' or category ~* '#{event_title}')",Date.today])
    #    user_loc = Geokit::Geocoders::GoogleGeocoder.reverse_geocode "#{latitude},#{longitude}"
    user_loc = Geokit::Geocoders::MultiGeocoder.geocode(address)
    events.sort_by_distance_from(user_loc)
    events.to_json()
  end

  private
  def price_must_be_atleast_a_cent
    errors.add(:price,'should be a digit and atleast 0.01') if !price.blank? && price<0.0
  end

  def validate_fields
    errors.add("Enter atleast one URL for the following: Webpage (or) Poster (or) Video") if web_page_link.blank? && image_link.nil? && video_link.blank?
    errors.add("Enter Event date") if date.nil?
  end

  def geocode_address
    geo=Geokit::Geocoders::MultiGeocoder.geocode(address)
    errors.add("Could not Geocode address") if !geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end
end

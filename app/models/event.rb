include Geokit::Geocoders

class Event < ActiveRecord::Base
  @photo_path = "/assets/events/:id/:style/:basename.:extension"
  belongs_to :user
  has_many :registrations

  has_attached_file :poster, :styles => { :small => "150x150>",:medium => "200x200>",:large => "320x240>" },
    :url => @photo_path,
    :path => ":rails_root/public/assets/events/:id/:style/:basename.:extension"

  validates_attachment_size :poster, :less_than => 15.megabytes
  validates_attachment_content_type :poster, :content_type => [ 'image/jpeg','image/png']
  validate :price_must_be_atleast_a_cent
  validate :validate_fields
  validate :geocode_address

  #  acts_as_mappable :auto_geocode=>{:field=>:address, :error_message=>'Could not geocode address'}
  
  def self.find_all_events 
    Event.find(:all, :order=>"date desc", :conditions=>['date > ?',Date.today])
  end

  def self.find_user_events(user_id)
    Event.find(:all, :order=>"date desc", :conditions=>['date > ? and user_id == ?',Date.today,user_id])
  end

  private
  def price_must_be_atleast_a_cent
    errors.add(:price,'should be a digit and atleast 0.01') if !price.blank? && price<0.01
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

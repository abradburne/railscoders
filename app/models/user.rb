require 'digest/sha2'
require 'rss/2.0'

class User < ActiveRecord::Base
  attr_protected :hashed_password, :enabled
  attr_accessor :password

  validates_presence_of :username 
  validates_presence_of :email 
  validates_presence_of :password, :if => :password_required?
  validates_presence_of :password_confirmation, :if => :password_required?

  validates_confirmation_of :password, :if => :password_required?
  
  validates_uniqueness_of :username, :case_sensitive => false
  validates_uniqueness_of :email, :case_sensitive => false
  
  validates_length_of :username, :within => 3..64
  validates_length_of :email, :within => 5..128  
  validates_length_of :password, :within => 4..20, :if => :password_required?
  validates_length_of :profile, :maximum => 1000

  has_and_belongs_to_many :roles
  has_many :articles
  has_many :entries
  has_many :comments
  has_many :photos, :extend => TagCountsExtension

  has_many :topics
  has_many :posts
  
  has_many :friendships
  has_many :friends, :through => :friendships, :class_name => 'User'
  has_many :usertemplates

  def before_save
    self.hashed_password = User.encrypt(password) if !password.blank?
    if self.has_attribute?('flickr_username') && !self.flickr_username.blank?
      self.flickr_id = self.get_flickr_id
    end
  end

  def password_required?
    hashed_password.blank? || !password.blank?
  end

  def self.encrypt(string)
    return Digest::SHA256.hexdigest(string)
  end
  
  def self.authenticate(username, password)
    find_by_username_and_hashed_password_and_enabled(username, 
        User.encrypt(password), true)
  end
  
  def has_role?(rolename)
    self.roles.find_by_name(rolename) ? true : false
  end
  
  def email_with_username
    "#{username} <#{email}>"
  end  
  
  def get_flickr_id
    # build the flickr request
    flickr_request = "http://api.flickr.com/services/rest/?"
    flickr_request += "method=flickr.people.findByUsername"
    flickr_request += "&username=#{self.flickr_username}"
    flickr_request += "&api_key=#{FLICKR_API_KEY}"

    # perform the API call
    response = ""
    open(flickr_request) do |s|
      response = s.read
    end

    # parse the result
    xml_response = REXML::Document.new(response)
    if xml_response.root.attributes["stat"] == 'ok'
      xml_response.root.elements["user"].attributes["nsid"]
    else
      nil
    end
  end
  
  def flickr_feed
    # build the flickr request
    flickr_request = "http://api.flickr.com/services/rest/?"
    flickr_request += "method=flickr.people.getPublicPhotos"
    flickr_request += "&per_page=4"
    flickr_request += "&user_id=#{self.flickr_id}"
    flickr_request += "&api_key=#{FLICKR_API_KEY}"

    # perform the API call
    response = ""
    open(flickr_request) do |s|
      response = s.read
    end
    
    # parse the result
    xml_response = REXML::Document.new(response)
    if xml_response.root.attributes["stat"] == 'ok'
      flickr_photos = []
      xml_response.root.elements.each("photos/photo") do |photo|
        photo_url =  "http://farm" + photo.attributes["farm"]
        photo_url += ".static.flickr.com/" + photo.attributes["server"]+"/" + photo.attributes["id"]
        photo_url += "_" + photo.attributes["secret"]+"_t.jpg"
        flickr_photos << photo_url
      end
      return flickr_photos
    else
      nil
    end
  end
  
  def to_liquid
    UserDrop.new(self)
  end
  
end

class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  validates_presence_of :title
  validates_presence_of :synopsis
  validates_presence_of :body
  validates_presence_of :title
  validates_length_of :title, :maximum => 255
  validates_length_of :synopsis, :maximum => 1000
  validates_length_of :body, :maximum => 20000

  before_save :update_published_at
  
  def update_published_at
    self.published_at = Time.now if published == true
  end
end

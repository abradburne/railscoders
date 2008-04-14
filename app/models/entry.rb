class Entry < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  has_many :comments
  validates_length_of :title, :maximum => 255
  validates_length_of :body, :maximum => 10000

  def after_save
    self.user.update_attribute(:last_activity, "Wrote a blog entry")
    self.user.update_attribute(:last_activity_at, Time.now)
  end
  
  def to_liquid
    EntryDrop.new(self)
  end
end

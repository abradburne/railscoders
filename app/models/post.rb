class Post < ActiveRecord::Base
  belongs_to :topic, :counter_cache => true
  belongs_to :user, :counter_cache => true

  validates_presence_of :body
  validates_length_of :body, :maximum => 10000

  def after_save
    self.user.update_attribute(:last_activity, "Posted in the forum")
    self.user.update_attribute(:last_activity_at, Time.now)
  end
end

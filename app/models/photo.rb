class Photo < ActiveRecord::Base
  has_attachment :storage => :file_system, 
                 :resize_to => '640x480',
                 :thumbnails => { :thumb => '160x120', :tiny => '50>' }, 
                 :max_size => 5.megabytes,
                 :content_type => :image,
                 :processor => 'Rmagick'
  validates_as_attachment
  acts_as_taggable
  belongs_to :user
  
  def after_save
    if self.user
      self.user.update_attribute(:last_activity, "Uploaded a photo")
      self.user.update_attribute(:last_activity_at, Time.now)
    end
  end
end

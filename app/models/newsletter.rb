class Newsletter < ActiveRecord::Base
  validates_presence_of :subject, :body
  validates_length_of :subject, :maximum => 255
  validates_length_of :body, :maximum => 10000
end

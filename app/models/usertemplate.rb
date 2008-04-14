class Usertemplate < ActiveRecord::Base
  belongs_to :user
  validates_length_of :body, :maximum => 10000
end

class Category < ActiveRecord::Base
  has_many :articles, :dependent => :nullify
  validates_length_of :name, :maximum => 80
end

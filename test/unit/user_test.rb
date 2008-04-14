require File.dirname(__FILE__) + '/../test_helper'

class UserTest < Test::Unit::TestCase
  fixtures :users

  def test_create_valid_user
    user = User.new(:username => 'fred', :email => 'fred@example.com', 
        :password => 'abc123', :password_confirmation => 'abc123', 
        :profile => 'A regular guy')
    assert user.save
  end
  def test_invalid_duplicate_username
    user = User.new(:username => 'joe', :email => 'fred@example.com', 
        :password => 'abc123', :password_confirmation => 'abc123', 
        :profile => 'A regular guy')
    assert !user.save
  end
end

require "#{File.dirname(__FILE__)}/../test_helper"

class MobileLoginStoriesTest < ActionController::IntegrationTest
  fixtures :users, :pages
    
  def test_valid_mobile_login
    get 'mobile/login'
    assert_response :success
    assert_template 'mobile/account/login'    

    post 'mobile/account/authenticate', :user => {:username => 'joe', :password => '12345'}
    assert_response :redirect
    follow_redirect!
    assert_response :success    
    assert_template 'mobile/pages/show'    
  end
  
  def test_invalid_mobile_login
    get 'mobile/login'
    assert_response :success
    assert_template 'mobile/account/login'    

    post 'mobile/account/authenticate', :user => {:username => 'joe', :password => 'wrong'}
    assert_response :redirect
    follow_redirect!
    assert_response :success    
    assert_template 'mobile/account/login'    
  end
end

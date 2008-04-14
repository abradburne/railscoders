require "#{File.dirname(__FILE__)}/../test_helper"

class LoginStoriesTest < ActionController::IntegrationTest
  fixtures :users, :pages
  
  def test_valid_login
    get edit_user_url(1)
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template 'account/login'

    go_to_login
    
    login :user => {:username => 'joe', :password => '12345'}
    
    get edit_user_url(1)
    assert_response :success
    assert_template 'users/edit'    
  end
  
  private
    
    def go_to_login
      get 'account/login'
      assert_response :success
      assert_template 'account/login'
    end
    
    def login(options)
      post 'account/authenticate', options
      assert_response :redirect
    end
end

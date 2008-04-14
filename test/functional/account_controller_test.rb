require File.dirname(__FILE__) + '/../test_helper'
require 'account_controller'

# Re-raise errors caught by the controller.
class AccountController; def rescue_action(e) raise e end; end

class AccountControllerTest < Test::Unit::TestCase
  fixtures :users
  
  def setup
    @controller = AccountController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_valid_login_and_redirect
    post :authenticate, :user => {:username => 'joe', :password => '12345'}
    assert session[:user]
    assert_response :redirect
  end
  def test_invalid_login
    post :authenticate, :user => {:username => 'joe', :password => 'abc'}
    assert !session[:user]
    assert_response :redirect
    assert_redirected_to :action => 'login'
    assert flash.has_key?(:error)
  end
  def test_logout
    post :authenticate, :user => {:username => 'joe', :password => '12345'}
    assert session[:user]
    post :logout
    assert !session[:user]
    assert_response :redirect
  end
end

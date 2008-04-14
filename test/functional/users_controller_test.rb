require File.dirname(__FILE__) + '/../test_helper'
require 'users_controller'

# Re-raise errors caught by the controller.
class UsersController; def rescue_action(e) raise e end; end

class UsersControllerTest < Test::Unit::TestCase
  def setup
    @controller = UsersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_signup_page
    get :new
    assert_response :success
  end
  def test_valid_signup_and_redirect
    post :create, :user => {:username => 'fred', 
                            :email => 'fred@example.com', 
                            :password => 'abc123', 
                            :password_confirmation => 'abc123', 
                            :profile => 'A regular guy'}
    assert_response :redirect
  end
  def test_invalid_signup_dupe_username
    post :create, :user => {:username => 'joe', 
                            :email => 'fred@example.com', 
                            :password => 'abc123', 
                            :password_confirmation => 'abc123', 
                            :profile => 'A regular guy'}
    assert assigns(:user).errors.on(:username)
    assert_response :success
    assert_template 'users/new'
  end
end

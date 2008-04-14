require File.dirname(__FILE__) + '/../test_helper'
require 'usertemplates_controller'

# Re-raise errors caught by the controller.
class UsertemplatesController; def rescue_action(e) raise e end; end

class UsertemplatesControllerTest < Test::Unit::TestCase
  fixtures :usertemplates, :users
  
  def setup
    @controller = UsertemplatesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    login_as(:valid_user)
    get :index
    assert_response :success
    assert assigns(:usertemplates)
  end

  def test_should_get_edit
    login_as(:valid_user)
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_usertemplate
    login_as(:valid_user)
    put :update, :id => 1, :usertemplate => { :body => 'a different template'}
    assert_redirected_to usertemplates_path
  end
  
  def test_should_fail_get_edit_for_other_user
    login_as(:valid_user)
    get :edit, :id => 3
    assert_response :redirect
    assert_redirected_to :action => 'index'
  end

  def test_should_fail_update_for_other_user
    login_as(:valid_user)
    put :update, :id => 3, :usertemplate => { :body => 'a different template'}
    assert_response :redirect
    assert_redirected_to :action => 'index'
  end
end

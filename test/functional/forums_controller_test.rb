require File.dirname(__FILE__) + '/../test_helper'
require 'forums_controller'

# Re-raise errors caught by the controller.
class ForumsController; def rescue_action(e) raise e end; end

class ForumsControllerTest < Test::Unit::TestCase
  fixtures :forums, :users, :roles, :roles_users

  def setup
    @controller = ForumsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:forums)
  end

  def test_should_get_new
    login_as(:moderator_user)
    get :new
    assert_response :success
  end

  def test_should_create_forum
    login_as(:moderator_user)    
    old_count = Forum.count
    post :create, :forum => { :name => 'testing', :description => 'just a test'}
    assert_equal old_count+1, Forum.count    
    assert_redirected_to forums_path
  end

  def test_should_show_forum
    get :show, :id => 1
    assert_redirected_to :controller => 'topics', :action => 'index', :forum_id => 1
  end

  def test_should_get_edit
    login_as(:moderator_user)    
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_forum
    login_as(:moderator_user)    
    put :update, :id => 1, :forum => { :name => 'testing', :description => 'a test'}    
    assert_redirected_to forum_path(assigns(:forum))
  end

  def test_should_destroy_forum
    login_as(:moderator_user)    
    old_count = Forum.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Forum.count
    
    assert_redirected_to forums_path
  end
end

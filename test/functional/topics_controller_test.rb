require File.dirname(__FILE__) + '/../test_helper'
require 'topics_controller'

# Re-raise errors caught by the controller.
class TopicsController; def rescue_action(e) raise e end; end

class TopicsControllerTest < Test::Unit::TestCase
  fixtures :topics, :forums, :users, :roles, :roles_users

  def setup
    @controller = TopicsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index, {:forum_id => 1}
    assert_response :success
    assert assigns(:topics)
  end
  
  def test_should_get_new
    login_as(:moderator_user)    
    get :new, {:forum_id => 1}
    assert_response :success
  end
    
  def test_should_create_topic
    login_as(:moderator_user)    
    old_count = Topic.count
    post :create, {:forum_id => 1, 
                   :topic => { :name => 'a test topic' }, 
                   :post => { :body => 'and the message'} }
    assert_equal old_count+1, Topic.count
    assert_redirected_to posts_path(:forum_id => 1, :topic_id => assigns(:topic))
  end
  
  def test_should_show_topic
    get :show, { :id => 1, :forum_id => 1 }
    assert_redirected_to :controller => 'posts', :action => 'index', 
                         :forum_id => 1, :topic_id => 1
    assert_redirected_to posts_path(:forum_id => 1, :topic_id => 1)
  end
  
  def test_should_get_edit
    login_as(:moderator_user)    
    get :edit, { :id => 1, :forum_id => 1 }
    assert_response :success
  end
    
  def test_should_update_topic
    login_as(:moderator_user)
    put :update, {:id => 1, :forum_id => 1, :topic => { :name => 'a test' } }
    assert_redirected_to :controller => 'posts', :action => 'index', 
                         :forum_id => 1, :topic_id => 1
  end
    
  def test_should_destroy_topic
    login_as(:moderator_user)
    old_count = Topic.count
    delete :destroy, { :id => 1, :forum_id => 1 }
    assert_equal old_count-1, Topic.count    
    assert_redirected_to topics_path(:forum_id => 1)
  end
end

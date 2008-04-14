require File.dirname(__FILE__) + '/../test_helper'
require 'posts_controller'

# Re-raise errors caught by the controller.
class PostsController; def rescue_action(e) raise e end; end

class PostsControllerTest < Test::Unit::TestCase
  fixtures :posts, :topics, :forums, :users, :roles, :roles_users

  def setup
    @controller = PostsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index, {:forum_id => 1, :topic_id => 1}
    assert_response :success
    assert assigns(:posts)
  end
  
  def test_should_get_new
    login_as(:valid_user)    
    get :new, {:forum_id => 1, :topic_id => 1}
    assert_response :success
  end
    
  def test_should_create_post
    login_as(:valid_user)
    old_count = Post.count
    post :create, {:forum_id => 1, :topic_id => 1, 
                   :post => { :body => 'test message' } }
    assert_equal old_count+1, Post.count
    assert_redirected_to posts_path(:forum_id => 1, :topic_id => 1)
  end
  
  def test_should_show_post
    get :show, {:id => 1, :forum_id => 1, :topic_id => 1}
    assert_response :success
  end
  
  def test_should_get_edit
    login_as(:moderator_user)    
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_post
    login_as(:moderator_user)    
    put :update, {:forum_id => 1, :topic_id => 1, :id => 1, 
                  :post => { :body => 'test message'} }    
    assert_redirected_to posts_path(:forum_id => 1, :topic_id => 1)
  end
    
  def test_should_destroy_post
    login_as(:moderator_user)    
    old_count = Post.count
    delete :destroy, :id => 1, :forum_id => 1, :topic_id => 1
    assert_equal old_count-1, Post.count    
    assert_redirected_to posts_path(:forum_id => 1, :topic_id => 1)
  end
end

require File.dirname(__FILE__) + '/../test_helper'
require 'friends_controller'

# Re-raise errors caught by the controller.
class FriendsController; def rescue_action(e) raise e end; end

class FriendsControllerTest < Test::Unit::TestCase
  fixtures :friendships, :users, :roles, :roles_users
  
  def setup
    @controller = FriendsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index, {:user_id => 1}
    assert_response :success
    assert assigns(:user)
  end

  def test_should_get_new
    login_as(:valid_user)    
    get :new, {:user_id => 1, :friend_id => 3}
    assert_response :success
  end
  
  def test_should_create_friendship
    login_as(:valid_user)
    old_count = Friendship.count
    post :create, {:user_id => 1, :friend_id => 3, :friendship => { :xfn_met => true } }
    assert_equal old_count + 1, Friendship.count
    assert_redirected_to friends_path(:user_id => 1)
  end

  def test_should_get_edit
    login_as(:valid_user)    
    get :edit, :user_id => 1, :id => 2
    assert_response :success
  end
  
  def test_should_update_friendship
    login_as(:valid_user)

    get :index, {:user_id => 1}
    assert_select "a#friend-2[rel~=crush]", false

    put :update, {:user_id => 1, :id => 2, :friendship => { :xfn_crush => true} }    
    assert_redirected_to friends_path(:user_id => 1)

    get :index, {:user_id => 1}
    assert_response :success
    assert_select "a#friend-2[rel~=crush]", true
  end

  def test_should_destroy_friendship
    login_as(:valid_user)    
    old_count = Friendship.count
    delete :destroy, :user_id => 1, :id => 2
    assert_equal old_count - 1, Friendship.count    
    assert_redirected_to friends_path(:user_id => 1)
  end
  
end

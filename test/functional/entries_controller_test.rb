require File.dirname(__FILE__) + '/../test_helper'
require 'entries_controller'

# Re-raise errors caught by the controller.
class EntriesController; def rescue_action(e) raise e end; end

class EntriesControllerTest < Test::Unit::TestCase
  fixtures :entries, :users

  def setup
    @controller = EntriesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index, {:user_id => 1}
    assert_response :success
    assert assigns(:entries)
  end

  def test_should_get_new
    login_as(:valid_user)
    get :new, {:user_id => 1}
    assert_response :success
  end
  
  def test_should_create_entry
    login_as(:valid_user)
    old_count = Entry.count
    post :create, :entry => {:title => 'test entry', :body => 'a blog entry'}
    assert_equal old_count+1, Entry.count    
    assert_redirected_to entry_path(:user_id => 1, :id => assigns(:entry))    
  end
  
  def test_should_show_entry
    get :show, {:user_id => 1, :id => 1}
    assert_response :success
  end
  
  def test_should_get_edit
    login_as(:valid_user)    
    get :edit, {:user_id => 1, :id => 1}
    assert_response :success
  end
  
  def test_should_update_entry
    login_as(:valid_user)
    put :update, {:user_id => 1, :id => 1, 
                  :entry => {:title => 'test entry', :body => 'a blog entry'} }
    assert_redirected_to entry_path(:user_id => 1, :id => 1)    
  end
  
  def test_should_destroy_entry
    login_as(:valid_user)
    old_count = Entry.count
    delete :destroy, {:user_id => 1, :id => 1}
    assert_equal old_count-1, Entry.count    
    assert_redirected_to entries_path
  end
end

require File.dirname(__FILE__) + '/../test_helper'
require 'comments_controller'

# Re-raise errors caught by the controller.
class CommentsController; def rescue_action(e) raise e end; end

class CommentsControllerTest < Test::Unit::TestCase
  fixtures :comments, :users, :entries

  def setup
    @controller = CommentsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_create_comment
    login_as(:valid_user)
    old_count = Comment.count
    post :create,{:user_id => 1, :entry_id => 1,
    :comment => {:body => 'that is great'}}
    assert_equal old_count+1, Comment.count
    assert_redirected_to entry_path(:user_id => 1, :id => 1)
  end

  def test_should_destroy_comment
    login_as(:valid_user)
    old_count = Comment.count
    delete :destroy, :user_id => 1, :entry_id => 1, :id => 1
    assert_equal old_count-1, Comment.count
    assert_redirected_to entry_path(:user_id => 1, :id => 1)
  end
  
  def test_send_notify_email
    num_deliveries = ActionMailer::Base.deliveries.size
    
    login_as(:valid_user)    
    post :create,{:user_id => 1, :entry_id => 1, 
                  :comment => {:body => 'that is great'}}
    
    assert_equal num_deliveries + 1, ActionMailer::Base.deliveries.size
  end
end

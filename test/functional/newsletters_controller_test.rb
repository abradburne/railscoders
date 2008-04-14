require File.dirname(__FILE__) + '/../test_helper'
require 'newsletters_controller'

# Re-raise errors caught by the controller.
class NewslettersController; def rescue_action(e) raise e end; end

class NewslettersControllerTest < Test::Unit::TestCase
  fixtures :newsletters, :users, :roles, :roles_users

  def setup
    @controller = NewslettersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    login_as(:admin_user)    
    get :index
    assert_response :success
    assert assigns(:newsletters)
  end

  def test_should_get_new
    login_as(:admin_user)    
    get :new
    assert_response :success
  end
  
  def test_should_create_newsletter
    login_as(:admin_user)    
    old_count = Newsletter.count
    post :create, :newsletter => { :subject => 'new newsletter', :body => 'interesting news goes here' }
    assert_equal old_count+1, Newsletter.count
    
    assert_redirected_to newsletter_path(assigns(:newsletter))
  end

  def test_should_show_newsletter
    login_as(:admin_user)    
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    login_as(:admin_user)    
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_newsletter
    login_as(:admin_user)    
    put :update, :id => 1, :newsletter => { :subject => 'new newsletter', :body => 'interesting news goes here' }
    assert_redirected_to newsletter_path(assigns(:newsletter))
  end
  
  def test_should_destroy_newsletter
    login_as(:admin_user)    
    old_count = Newsletter.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Newsletter.count
    
    assert_redirected_to newsletters_path
  end
end

require File.dirname(__FILE__) + '/../test_helper'
require 'articles_controller'

class ArticlesController; def rescue_action(e) raise e end; end

class ArticlesControllerTest < Test::Unit::TestCase
  fixtures :articles, :users, :roles, :roles_users
  
  def setup
    @controller = ArticlesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:articles)
  end
  
  def test_index_as_xml
    @request.env['HTTP_ACCEPT'] = 'application/xml'
    get :index
    assert_response :success
    assert_not_nil assigns(:articles)
  end
  
  def test_show
    get :show, :id => 1
    assert_response :success
    assert_not_nil assigns(:article)
  end

  def test_create_article_with_http_auth_and_xml
    old_count = Article.count
    @request.env['HTTP_ACCEPT'] = 'application/xml'    
    @request.env['Authorization'] = 'Basic ' + Base64::b64encode('editor:12345')
    
    post :create, :article => { :title => 'New article', :synopsis => 'Just a test',
      :body => 'Nothing to see here', :published => true }
      
    assert_response :success
    assert_equal old_count + 1, Article.count
    assert_not_nil assigns(:article)
  end
  
  def test_rest_routing
    with_options :controller => 'articles' do |test|
      test.assert_routing 'articles', :action => 'index'
      test.assert_routing 'articles/1', :action => 'show', :id => '1'
    end
  end
end

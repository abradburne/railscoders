require "#{File.dirname(__FILE__)}/../test_helper"

class ArticleStoriesTest < ActionController::IntegrationTest
  fixtures :users, :articles, :categories
    
  def test_view_all_articles
    get articles_url
    assert_response :success
    assert_template 'articles/index'    
    assert_equal assigns['articles'].length, 2
  end
  
  def test_view_one_category
    get category_articles_url(:category_id => 1)
    assert_response :success
    assert_template 'articles/index'    
    assert_equal assigns['articles'].length, 1
  end
end

require File.dirname(__FILE__) + '/../test_helper'
require 'backend_controller'

class BackendController; def rescue_action(e) raise e end; end

class BackendControllerApiTest < Test::Unit::TestCase
  fixtures :users, :entries
  
  def setup
    @controller = BackendController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  def test_get_users_blogs
    blogs = invoke_layered :blogger, :getUsersBlogs, '', 'joe', '12345'
    assert_equal '1', blogs[0]['blogId']
  end
  
  def test_get_post
    entry = invoke_layered :blogger, :getPost, '', '1', 'joe', '12345'
    assert_equal '1', entry['postId']
  end
  
  def test_get_recent_posts
    entries = invoke_layered :blogger, :getRecentPosts, '', '1', 'joe', '12345', '1'
    assert_equal 1, entries.size
    assert_equal '1', entries[0]['postId']
  end
  
  def test_new_post
    blogs = invoke_layered :blogger, :getUsersBlogs, '', 'joe', '12345'
    new_post = invoke_layered :blogger, :newPost, '', blogs[0]['blogId'], 
      'joe', '12345', 'New Post', true
    assert new_post.is_a?(Integer)    
  end
    
  def test_new_and_edit_post
    blogs = invoke_layered :blogger, :getUsersBlogs, '', 'joe', '12345'
    new_post = invoke_layered :blogger, :newPost, '', blogs[0]['blogId'], 
      'joe', '12345','New Post', true
    result = invoke_layered :blogger, :editPost, '', new_post, 'joe', '12345', 
      'Edited Post', true
    assert_equal true, result
  end
end

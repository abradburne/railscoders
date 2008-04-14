require File.dirname(__FILE__) + '/../test_helper'
require 'user_tags_controller'

# Re-raise errors caught by the controller.
class UserTagsController; def rescue_action(e) raise e end; end

class UserTagsControllerTest < Test::Unit::TestCase
  def setup
    @controller = UserTagsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end

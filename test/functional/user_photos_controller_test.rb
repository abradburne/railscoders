require File.dirname(__FILE__) + '/../test_helper'
require 'user_photos_controller'

# Re-raise errors caught by the controller.
class UserPhotosController; def rescue_action(e) raise e end; end

class UserPhotosControllerTest < Test::Unit::TestCase
 fixtures :photos, :users

 def setup
   @controller = UserPhotosController.new
   @request    = ActionController::TestRequest.new
   @response   = ActionController::TestResponse.new
 end

 def test_should_get_index
   get :index, {:user_id => 1}
   assert_response :success
   assert assigns(:photos)
 end

 def test_should_get_new
   login_as(:valid_user)
   get :new, {:user_id => 1}
   assert_response :success
 end

 def test_should_create_photo
   login_as(:valid_user)
   old_count = Photo.count
   image_file = File.join(RAILS_ROOT, 'public', 'images', 'rails.png')

   post :create,
        :photo => {:title => 'test photo',
                   :body => 'a test image',
                   :temp_path => image_file,
                   :content_type => 'image/png',
                   :filename => 'rails.png'}

   assert_equal old_count+3, Photo.count
   assert_redirected_to user_photos_path(:user_id => 1)
 end

 def test_should_show_photo
   get :show, {:user_id => 1, :id => 1}
   assert_response :success
 end

 def test_should_get_edit
   login_as(:valid_user)
   get :edit, {:user_id => 1, :id => 1}
   assert_response :success
 end

 def test_should_update_photo
   login_as(:valid_user)

   # upload a test image
   image_file = File.join(RAILS_ROOT, 'public', 'images', 'rails.png')
   post :create,
        :photo => {:title => 'test photo',
                   :body => 'a test image',
                   :temp_path => image_file,
                   :content_type => 'image/png',
                   :filename => 'rails.png'}

   put :update, {:user_id => assigns['photo'].user_id, :id => assigns['photo'].id, :photo => {:body => 'this has been edited' }}
   assert_redirected_to user_photo_path(:user_id => assigns['photo'].user_id, :id => assigns['photo'].id)
 end

 def test_should_destroy_photo
   login_as(:valid_user)

   # upload a test image
   image_file = File.join(RAILS_ROOT, 'public', 'images', 'rails.png')
   post :create,
        :photo => {:title => 'test photo',
                   :body => 'a test image',
                   :temp_path => image_file,
                   :content_type => 'image/png',
                   :filename => 'rails.png'}


   old_count = Photo.count
   delete :destroy, {:user_id => assigns['photo'].user_id, :id => assigns['photo'].id}
   assert_equal old_count-3, Photo.count

   assert_redirected_to user_photos_path
 end
end

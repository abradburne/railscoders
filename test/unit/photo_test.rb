require File.dirname(__FILE__) + '/../test_helper'

class PhotoTest < Test::Unit::TestCase
  fixtures :photos, :users

  def test_should_upload_photo_and_create_thumbnails
    photo_object = upload_file 'rails.png', users(:valid_user)
    assert_file_exists photo_object.id, "rails.png"
    assert_file_exists photo_object.id, "rails_thumb.png"
    assert_file_exists photo_object.id, "rails_tiny.png"
  end
  
  def test_should_delete_db_row_and_files
    photo_object = upload_file 'rails.png', users(:valid_user)
    photo_count = Photo.count

    assert_file_exists photo_object.id, "rails.png"
    Photo.destroy(photo_object.id)

    assert_equal photo_count-3, Photo.count
    assert_file_does_not_exist photo_object.id, "rails.png"
    assert_file_does_not_exist photo_object.id, "rails_thumb.png"
    assert_file_does_not_exist photo_object.id, "rails_tiny.png"
  end

  protected
    def upload_file(image_file, user)
      image_file = File.join(RAILS_ROOT, 'public', 'images', image_file)
      photo = user.photos.create(:filename => image_file, 
                                 :content_type => 'image/png',
                                 :temp_path => image_file)
      assert_valid photo
      photo
    end
    
    def assert_file_exists(photo_id, image_file)
      file = File.join(RAILS_ROOT, 'public', 'photos', 
                       "#{photo_id}", "#{image_file}")
      assert File.file?(file), "File not found: #{image_file}"      
    end

    def assert_file_does_not_exist(photo_id, image_file)
      file = File.join(RAILS_ROOT, 'public', 'photos', 
                       "#{photo_id}", "#{image_file}")
      assert !File.file?(file)
    end
end

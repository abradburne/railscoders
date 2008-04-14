require File.dirname(__FILE__) + '/../test_helper'

class PageTest < Test::Unit::TestCase
  fixtures :pages

  def test_invalid_if_any_field_empty
    page = Page.new
    assert !page.valid?
    assert page.errors.invalid?(:title)
    assert page.errors.invalid?(:body)    
  end
  def test_valid_fields
    page = pages(:valid_page)
    assert page.valid?
  end
  def test_invalid_short_title 
    page = pages(:invalid_page_short_title)
     assert !page.valid?
  end
  
  def test_auto_permalink
    page = pages(:valid_with_auto_permalink)
    assert page.valid?
  end
end

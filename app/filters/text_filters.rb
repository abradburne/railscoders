module TextFilters
  include ActionView::Helpers::TagHelper

  def textilize(input)
    RedCloth.new(input).to_html
  end

  def link_to_entry(entry)
    content_tag :a, entry['title'], :href => entry['permalink']
  end
end
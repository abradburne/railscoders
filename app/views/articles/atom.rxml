xml.instruct!

xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do

  xml.title   "RailsCoders News"
  xml.link    "rel" => "self", "href" => articles_url
  xml.link    "rel" => "alternate", "href" => articles_url
  xml.id      articles_url
  if @articles.any?
    xml.updated @articles.first.updated_at.strftime "%Y-%m-%dT%H:%M:%SZ" 
  end
  xml.author  { xml.name "RailsCoders Site" }

  @articles.each do |article|
    xml.article do
      xml.title   article.title
      xml.link    "rel" => "alternate", "href" => article_url(article)
      xml.id      article_url(article)
      xml.updated article.updated_at.strftime "%Y-%m-%dT%H:%M:%SZ"
      xml.author  { xml.name article.user.username }
      xml.summary article.synopsis
      xml.content "type" => "html" do
        xml.text! textilize(article.body)
      end
    end
  end

end

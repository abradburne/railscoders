class Mobile::ArticlesController < ArticlesController
  layout 'mobile'
  
  def index
    if params[:category_id]
      @articles_pages, @articles = paginate :articles, 
        :include => :user, 
        :per_page => 5,
        :order => 'published_at DESC',
        :conditions => "category_id = #{params[:category_id].to_i} AND published = true"
    else
      @articles_pages, @articles = paginate :articles, 
        :include => :user,
        :per_page => 5,
        :order => 'published_at DESC', 
        :conditions => "published = true"      
    end
  end
end
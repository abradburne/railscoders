class ArticlesController < ApplicationController
  before_filter :check_editor_role, :except => [:index, :show]

  def index
    if params[:category_id]
      @articles_pages, @articles = paginate(:articles, 
        :include => :user, 
        :order => 'published_at DESC',
        :conditions => "category_id=#{params[:category_id].to_i} AND published=true")
    else
      @articles = Article.find_all_by_published(true)
      @articles_pages, @articles = paginate(:articles, 
        :include => :user,
        :order => 'published_at DESC', 
        :conditions => "published = true")        
    end
    respond_to do |wants|
      wants.html
      wants.xml  { render :xml => @articles.to_xml }
      wants.rss  { render :action => 'rss.rxml', :layout => false }
      wants.atom { render :action => 'atom.rxml', :layout => false }
    end
  end

  def show
    if is_logged_in? && @logged_in_user.has_role?('Editor')
      @article = Article.find(params[:id])
    else
      @article = Article.find_by_id_and_published(params[:id], true)
    end
    respond_to do |wants|
      wants.html
      wants.xml { render :xml => @article.to_xml }
    end
  end
  
  def new  
    @article = Article.new
  end
  
  def create
    @article = Article.create(params[:article])
    @logged_in_user.articles << @article
    respond_to do |wants|
      wants.html { redirect_to admin_articles_url }
      wants.xml  { render :xml => @article.to_xml }
    end
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    @article.update_attributes(params[:article])
    respond_to do |wants|
      wants.html { redirect_to admin_articles_url }
      wants.xml  { render :xml => @article.to_xml }
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    respond_to do |wants|
      wants.html { redirect_to admin_articles_url }
      wants.xml  { render :nothing => true }
    end
  end

  def admin
    @articles_pages, @articles = paginate(:articles, :order => 'published_at DESC')
  end

end

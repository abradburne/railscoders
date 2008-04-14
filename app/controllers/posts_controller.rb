class PostsController < ApplicationController
  # before_filter :check_moderator_role, :only => [:destroy, :edit, :update]
  before_filter :check_moderator_role, :only => [:destroy]
  before_filter :login_required, :except => [:index, :show]
  
  # GET /posts
  # GET /posts.xml
  def index
    @topic = Topic.find(params[:topic_id], :include => :forum) 
    @posts_pages, @posts = paginate(:posts, 
        :include => :user, 
        :conditions => ['topic_id = ?', @topic])
  
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @posts.to_xml }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @post.to_xml }
    end
  end

  # GET /posts/new
  def new
    @topic = Topic.find(params[:topic_id], :include => :forum)
    @post = Post.new
  end

  # GET /posts/1;edit
  def edit
    @post = @logged_in_user.posts.find(params[:id], :include => { :topic => :forum })
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'    
  end

  # POST /posts
  # POST /posts.xml
  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.new(:body => params[:post][:body],
                     :topic_id => @topic.id, 
                     :user_id => logged_in_user.id)    

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to posts_path(:forum_id => @topic.forum_id, 
                                           :topic_id => @topic) }
        format.xml  { head :created, :location => post_path(@post) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors.to_xml }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = @logged_in_user.posts.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
         format.html { redirect_to posts_path(:forum_id => params[:forum_id], 
                                              :topic_id => params[:topic_id]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors.to_xml }
      end
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'    
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
       format.html { redirect_to posts_path(:forum_id => params[:forum_id], 
                                            :topic_id => params[:topic_id]) }
      format.xml  { head :ok }
    end
  end
end

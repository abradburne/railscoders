class TopicsController < ApplicationController
  before_filter :check_moderator_role, :only => [:destroy, :edit, :update]
  before_filter :login_required, :except => [:index, :show]

  # GET /topics
  # GET /topics.xml
  def index
    @forum = Forum.find(params[:forum_id])
    @topics_pages, @topics = paginate(:topics, 
        :include => :user, 
        :conditions => ['forum_id = ?', @forum], 
        :order => 'topics.updated_at DESC') 

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @topics.to_xml }
    end
  end

  # GET /topics/1
  # GET /topics/1.xml
  def show
    redirect_to posts_path(:forum_id => params[:forum_id], :topic_id => params[:id])
  end

  # GET /topics/new
  def new
    @topic = Topic.new
    @post = Post.new
  end

  # GET /topics/1;edit
  def edit
    @topic = Topic.find(params[:id])
  end

  def create    
    @topic = Topic.new(:name => params[:topic][:name], 
                       :forum_id => params[:forum_id], 
                       :user_id => logged_in_user.id)
    @topic.save!
    @post = Post.new(:body => params[:post][:body], 
                     :topic_id => @topic.id, 
                     :user_id => logged_in_user.id)
    @post.save!
    respond_to do |format|
      format.html { redirect_to posts_path(:topic_id => @topic, 
        :forum_id => @topic.forum.id) }
      format.xml  { head :created, :location => topic_path(:id => @topic, 
        :forum_id => @topic.forum.id) }
    end
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|  
      format.html { render :action => 'new' }
      format.xml  { render :xml => @post.errors.to_xml }
    end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        flash[:notice] = 'Topic was successfully updated.'
         format.html { redirect_to posts_path(:topic_id => @topic, 
         :forum_id => @topic.forum) }
      format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors.to_xml }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic = Topic.find(params[:id])
    @topic.posts.each { |post| post.destroy }
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to topics_path(:forum_id => 
        params[:forum_id]) }
      format.xml  { head :ok }
    end
  end
end

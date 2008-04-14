class Mobile::PostsController < PostsController
  layout 'mobile'
  
  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.new(:body => params[:post][:body],
                     :topic_id => @topic.id, 
                     :user_id => logged_in_user.id)    

    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to mobile_posts_path(:forum_id => @topic.forum_id, :topic_id => @topic)
    else
      render :action => "new"
    end    
  end
end
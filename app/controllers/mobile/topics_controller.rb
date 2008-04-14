class Mobile::TopicsController < TopicsController
  layout 'mobile'
  
  def show
    redirect_to mobile_posts_path(:forum_id => params[:forum_id], 
                                  :topic_id => params[:id])
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
    
    redirect_to mobile_posts_path(:topic_id => @topic, :forum_id => @topic.forum)
  end
end
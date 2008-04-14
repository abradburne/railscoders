class BloggerService < ActionWebService::Base
  web_service_api BloggerAPI

  def getUsersBlogs(appkey, username, password)
    if @user = User.authenticate(username, password)
      [BloggerStructs::Blog.new(
        :url => "http://localhost:3000/users/#{@user.id}/entries",
        :blogId => @user.id,
        :blogName => @user.blog_title ||= @user.username
      )]
    end
  end
  
  def getPost(appkey, postid, username, password)
    if @user = User.authenticate(username, password)
      entry = @user.entries.find(postid)
      BloggerStructs::Post.new(
        :userId => @user.id,
        :postId => entry.id,
        :dateCreated => entry.created_at.to_s(:db),
        :content => [entry.body]
      )
    end
  end

  def getRecentPosts(appkey, blogid, username, password, numberofposts)
    if @user = User.authenticate(username, password)
      @user.entries.find(:all, 
                         :order => 'created_at DESC', 
                         :limit => numberofposts).collect do |entry|
        BloggerStructs::Post.new(
          :userId => entry.user_id,
          :postId => entry.id,
          :dateCreated => entry.created_at.to_s(:db),
          :content => entry.body
        )
      end
    end
  end

  def getUserInfo(appkey, username, password)
    if @user = User.authenticate(username, password)
      BloggerStructs::User.new(
        :userId => @user.id,
        :username => @user.username,
        :url => "http://localhost:3000/users/#{@user.id}/entries"
      )
    end
  end

  def newPost(appkey, blogid, username, password, content, publish)
    if @user = User.authenticate(username, password)
      entry = Entry.new
      entry.title = "New entry"
      entry.body = content.to_s
      entry.user = @user
      entry.save
      return entry.id
    end
  end

  def editPost(appkey, postid, username, password, content, publish)
    if @user = User.authenticate(username, password)
      entry = @user.entries.find(postid)
      entry.body = content
      entry.save
      return true
    end
  end
end

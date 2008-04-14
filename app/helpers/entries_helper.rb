module EntriesHelper
  def blog_title(user)
    user.blog_title ||= user.username    
  end
end

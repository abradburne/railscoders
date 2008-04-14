class UserDrop < Liquid::Drop
  def initialize(user)
    @user = user
  end
  
  def username
    @user[:username]
  end
  
  def email
    @user[:email]
  end
  
  def profile
    @user[:profile]
  end
  
  def blog_title
    @user[:blog_title]
  end
end
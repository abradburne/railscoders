class Mobile::AccountController < AccountController  
  layout 'mobile'

  def authenticate
    self.logged_in_user = User.authenticate(params[:user][:username], params[:user][:password])
    if is_logged_in?
      flash[:notice] = "You have successfully logged in."
      redirect_to mobile_index_url
    else
      flash[:error] = "I'm sorry; either your email or password was incorrect."
      redirect_to :action => 'login'
    end  
  end
  
  def logout
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_to mobile_index_url
  end
end

class AccountController < ApplicationController  
  
  def authenticate
    self.logged_in_user = User.authenticate(params[:user][:username], 
        params[:user][:password])
    if is_logged_in?
      redirect_to index_url
    else
      flash[:error] = "I'm sorry, either your username or password was incorrect."
      redirect_to :action => 'login'
    end  
  end
  
  def logout
    if request.post?
      reset_session
      flash[:notice] = "You have been logged out."
    end
    redirect_to index_url
  end
  
end

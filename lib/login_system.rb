module LoginSystem
  protected
   
  def is_logged_in?
    username, password = get_http_auth_data
    @logged_in_user = User.find(session[:user]) if session[:user]
    @logged_in_user = User.authenticate(username, password) if username && password
    @logged_in_user ? @logged_in_user : false
  end
  
  def logged_in_user
    return @logged_in_user if is_logged_in?
  end
  
  def logged_in_user=(user)
    if !user.nil?
      session[:user] = user.id
      @logged_in_user = user
    end
  end

  def self.included(base)
    base.send :helper_method, :is_logged_in?, :logged_in_user
  end  

  def check_role(role)
    unless is_logged_in? && @logged_in_user.has_role?(role)
      respond_to do |wants|
        wants.html do
          flash[:error] = "You do not have the permission to do that."
          redirect_to :controller => 'account', :action => 'login'
        end
        wants.xml do
          headers['Status']           = 'Unauthorized'
          headers['WWW-Authenticate'] = %(Basic realm="Password")
          render :text => "Insuffient permission", 
                 :status => '401 Unauthorized', 
                 :layout => false
        end 
      end
    end
  end

  def login_required
    unless is_logged_in?
      respond_to do |wants|
        wants.html do
          flash[:error] = "You must be logged in to do that."
          redirect_to :controller => 'account', :action => 'login'
        end
        wants.xml do
          headers["Status"]           = "Unauthorized"
          headers["WWW-Authenticate"] = %(Basic realm="Web Password")
          render :text => "Could't authenticate you", 
                 :status => '401 Unauthorized', 
                 :layout => false    
        end
      end
    end
  end
  
  def check_administrator_role
    check_role('Administrator')
  end
  
  def check_editor_role
    check_role('Editor')
  end
  
  def check_moderator_role
    check_role('Moderator')
  end
  
  def login_required
    unless is_logged_in?
      respond_to do |wants|
        wants.html do
          flash[:error] = "You must be logged in to do that."
          redirect_to :controller => 'account', :action => 'login'
        end
        wants.xml do
          headers["Status"]           = "Unauthorized"
          headers["WWW-Authenticate"] = %(Basic realm="Web Password")
          render :text => "Could't authenticate you", 
                 :status => '401 Unauthorized', 
                 :layout => false    
        end
      end
    end
  end

private
  def get_http_auth_data
    username, password = nil, nil
    auth_headers = ['X-HTTP_AUTHORIZATION', 'Authorization', 'HTTP_AUTHORIZATION', 
      'REDIRECT_REDIRECT_X_http_AUTHORIZATION']
    auth_header = auth_headers.detect { |key| request.env[key] }
    auth_data = request.env[auth_header].to_s.split

    if auth_data && auth_data[0] == 'Basic'
      username, password = Base64.decode64(auth_data[1]).split(':')[0..1] 
    end 
    return [username, password]
  end
end

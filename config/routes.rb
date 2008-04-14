ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  # map.connect '', :controller => "welcome"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'


  # RailsCoders routes
  map.index '/', :controller => 'pages', 
                 :action => 'show', 
                 :id => '1-welcome-page'

  map.resources :pages
  map.resources :blogs
  map.resources :photos
  map.resources :tags
  map.resources :usertemplates
    
  map.resources :users, :member => { :enable => :put } do |users|
    users.resources :roles
    users.resources :entries do |entry|
      entry.resources :comments
    end
    users.resources :friends
    users.resources :tags, :name_prefix => 'user_',
                           :controller => 'user_tags'
    users.resources :photos, :name_prefix => 'user_',
                             :controller => 'user_photos',
                             :member => { :add_tag => :put, :remove_tag => :delete }
  end

  map.resources :articles, :collection => {:admin => :get}

  map.resources :categories, :collection => {:admin => :get} do |categories|
    categories.resources :articles, :name_prefix => 'category_'
  end
  
  map.resources :forums do |forum|
    forum.resources :topics do |topic|
      topic.resources :posts
    end
  end
  
  map.resources :newsletters, :member => { :sendmails => :put }

  map.show_user '/user/:username', 
                 :controller => 'users', 
                 :action => 'show_by_username'
                 

  # Mobile Routes

  map.resources :pages, 
                :controller => 'mobile/pages', 
                :path_prefix => '/mobile',
                :name_prefix => 'mobile_'
  
  map.resources :articles, 
                :controller => 'mobile/articles', 
                :path_prefix => '/mobile',
                :name_prefix => 'mobile_'

  map.resources :blogs,
                :controller => 'mobile/blogs', 
                :path_prefix => '/mobile',
                :name_prefix => 'mobile_'

  map.resources :photos, 
                :controller => 'mobile/photos', 
                :path_prefix => '/mobile',
                :name_prefix => 'mobile_'

  map.resources :categories, 
                :controller => 'mobile/categories', 
                :path_prefix => '/mobile',
                :name_prefix => 'mobile_' do |categories|
    categories.resources :articles, 
                  :controller => 'mobile/articles', 
                  :name_prefix => 'mobile_category_'
  end

  map.resources :users, 
                :controller => 'mobile/users',
                :path_prefix => '/mobile',
                :name_prefix => 'mobile_' do |users|
    users.resources :photos,
                    :controller => 'mobile/user_photos',
                    :name_prefix => 'mobile_user_'
    users.resources :entries,
                    :controller => 'mobile/entries',
                    :name_prefix => 'mobile_'
  end
  
  map.resources :forums, 
                :controller => 'mobile/forums', 
                :path_prefix => '/mobile',
                :name_prefix => 'mobile_' do |forums|
    forums.resources :topics,
                     :controller => 'mobile/topics', 
                     :name_prefix => 'mobile_' do |topics|
      topics.resources :posts,
                       :controller => 'mobile/posts', 
                       :name_prefix => 'mobile_'    
    end
  end

  map.mobile_index '/mobile', :controller => 'mobile/pages',
                              :action => 'show', 
                              :id => "1"

  map.mobile_show_user  '/mobile/user/:username', :controller => 'mobile/users', :action => 'show_by_username'
  map.mobile_all_blogs  '/mobile/blogs', :controller => 'mobile/blogs', :action => 'index'
  map.mobile_all_photos '/mobile/photos', :controller => 'mobile/photos', :action => 'index'
  
  map.mobile_login  '/mobile/login', :controller => 'mobile/account', :action => 'login'
  map.mobile_logout '/mobile/logout', :controller => 'mobile/account', :action => 'logout'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end

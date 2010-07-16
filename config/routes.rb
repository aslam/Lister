ActionController::Routing::Routes.draw do |map|
  map.resources :vendors

    map.resources :addresses

    map.resources :categories
    map.resources :lists
    map.export '/export', :controller => "admin/lists", :action => "export"

    map.resource :user_session
    map.root :controller => "user_sessions", :action => :new

    map.resource :account, :controller => "users"
    map.resources :users

    map.login   '/login', :controller => "user_sessions", :action => :new
    map.logout  '/logout', :controller => "user_sessions", :action => :destroy

    map.admin_login '/admin/login', :controller => 'admin/admin_sessions',
        :action => :new
    map.admin_logout '/admin/logout', :controller => 'admin/admin_sessions',
        :action => :destroy

    map.namespace :admin do |admin|
        admin.resource :admin_session
        admin.resource :account, :controller => "users"
        admin.resources :users
        admin.resources :lists
        admin.resources :categories
        map.connect '/admin/approve/:id', :controller => 'admin/lists', :action => 'approve'
        map.connect '/admin/reject/:id',  :controller => 'admin/lists', :action => 'reject'
        admin.root :controller => 'admin_sessions', :action => :new
    end

    map.connect ':controller/:action.:format'
    map.connect ':controller/:action/:id'
    map.connect ':controller/:action/:id.:format'
end


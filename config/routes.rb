ActionController::Routing::Routes.draw do |map|

  map.devise_for :users
  map.create_event 'users/:user_id/events/create_event',:controller => 'events', :action => 'create_event'
  map.show_user_events 'events/show_user_events/:id',:controller=>'events',:action=>'show_user_events'
  map.register_for_event 'event_registrations/:event_id/:appln_id.:format',:controller => 'event_registrations', :action => 'register'
  map.validate_registration 'validate_registration/:event_id/:appln_id/:confirmation.:format',:controller => 'event_registrations', :action => 'validate_registration'
  map.event_search "search.:format", :controller=>"events",:action=>"event_search"
  map.relevant_event_search "relevant_search.:format", :controller=>"events",:action=>"relevant_event_search"
  map.tag_search "tag_search.:format", :controller=>"events",:action=>"category_search"
  map.connect 'show_all_events',:controller => 'events',:action=>'show_all_events'

  map.resources :users, :has_many => [:events]
  map.resources :events, :has_many => [:registrations]

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "events", :action=>"show_all_events"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

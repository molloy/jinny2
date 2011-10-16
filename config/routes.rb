ActionController::Routing::Routes.draw do |map|
  resource :account, :controller => "people"
  
  resource :user_session
  
  resources :users do
    match 'export', :on => :collection
  end

  resources :departments

  resources :invoice_items

  resources :invoices

  resources :phones

  resources :addresses

  resources :degrees

  match '/people/register', :to => 'people#register'
  
  resources :people do
    match 'export', :on => :collection
    get 'autocomplete_degree_program_title', :on => :collection
    get 'autocomplete_department_name', :on => :collection
  end
  
  match 'course_offerings/:id/syllabus_data/:file_name', :to => 'course_offerings#syllabus_data'

  resources :course_offerings do
    match 'export', :on => :collection
    get 'autocomplete_course_number_and_name', :on => :collection
    get 'autocomplete_person_fullname', :on => :collection
  end

  resources :course_takens do
    match 'export', :on => :collection
  end

  resources :course_takens

  resources :phones

  resources :phones

  resources :addresses

  resources :majors

  resources :degrees

  resources :courses do
    match 'export', :on => :collection
    get 'autocomplete_department_name', :on => :collection
    get 'autocomplete_person_fullname', :on => :collection
  end

  resources :course_takens

  resources :courses do
    match 'export', :on => :collection
  end

  resources :course_taken_statuses

  resources :courses

  resources :phone_types

  resources :address_types

  resources :person_types

  resources :grade_types

  resources :term_types

  resources :term_types
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'

  root :to => "home#index"
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end

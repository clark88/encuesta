EncuestaProjekt::Application.routes.draw do
  get "user_answers/new"

  get "forms/new"
  
  get "forms/create"

  get "answers/new"

  get "answers/edit"

  get "answers/delete"

  get "questions/new"

  get "questions/edit"

  get "questions/delete"
  
 # get "questions/deleteanswers"

  get "surveytypes/new"

  get "surveytypes/edit"

  get "surveytypes/delete"

  get "sessions/new"


  get "users/new"
  
  get "users/edit"
  

  resources :users 
  resources :sessions, :only => [:new, :create, :destroy]
  resources :surveys do
   member do
    get 'lock'
   end
  end 
  resources :surveytypes
  resources :questions
  resources :answers
  resources :forms
  resources :user_answers
  resources :evaluation


  get "pages/home"
  get "pages/contact"
  get "pages/help"

  match '/signup',  :to => 'users#new'
  match '/edit',	:to => 'users#edit'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  
  
  match '/home',	:to => 'pages#home'
  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'
  

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

root :to => 'pages#home'
end
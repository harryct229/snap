Snap::Application.routes.draw do

  match '/all', to: 'categories#index'
  match '/admin/users', to: 'users#index'
  match '/admin/reports', to: 'reports#index'
  match '/admin/photos', to: 'photos#index'
  match '/admin/news', to: 'notifications#index'

  match '/reports/execute',to: 'reports#execute'

  match 'upload/pc' , to: 'photos#pc'

  match '/admin', to: 'users#admin_page'
  match '/search/name/' , to: 'searchs#search_name'
  match '/search/pin/',to: 'searchs#search_pin'
  match '/search', to: 'searchs#search_page'
  match '/toggle', to: 'users#toggle_active'

  get 'boxes/edit'
  get 'boxes/delete'

  resources :users do
      member do
      get :following, :followers, :photos, :likedphotos
    end
  end
  resources :boxes do
    member do
      get :followers
    end
  end

  resources :verifications
  resources :password_resets
  resources :reports
  # resources :categories
  resources :photos
  resources :sessions, only: [ :new, :create, :destroy]
  resources :user_box_follows, only: [ :create, :destroy]
  resources :user_user_relationships, only: [ :create, :destroy]
  resources :user_photo_actions, only: [ :create, :destroy]
  resources :authentications
  resources :find_friends, only: [ :find_facebook]
  resources :invitations, only: [ :index, :facebook, :twitter, :mail]

  root to: 'static_pages#home'


  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/about', to: 'static_pages#about'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/sendinvite', to: 'users#send_invite'
  match '/forgot', to: 'password_resets#new'
  # match '/editpassword', to: 'password_resets#edit'

  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/:provider/destroy' => 'authentications#destroy'

  match '/entry/findfriends' => 'find_friends#find_facebook'

  match '/invite/facebook' => 'invitations#facebook'
  match '/invite/twitter' => 'invitations#twitter'
  match '/invite/mail' => 'invitations#mail'
  match '/invite' => 'invitations#index'

  match '/upload', to: 'photos#new'
  match '/upload/facebook', to: 'photos#facebook'
  match '/upload/url', to: 'photos#url'
  match '/upload/pc', to: 'photos#pc'


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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

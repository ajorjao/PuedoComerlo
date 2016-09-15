Rails.application.routes.draw do

  resources :comments
  
  resources :notifications
  post 'sendemail' => 'notifications#create'
  
  devise_for :users, path: '', controllers: { registrations: "users/registrations", sessions: "users/sessions"}
  root 'home#index'

  devise_scope :user do
    post 'register' => 'users/registrations#create'
    get 'delete_avatar' => 'users/registrations#delete_avatar'
    get 'users/page/:page' => 'users/registrations#users'
    delete 'user/:id' => 'users/registrations#user_delete'
    get 'user' => 'users/sessions#user_actual'
    put 'user' => 'users/registrations#user_edit'
  end

  # resources :banned_users
  get 'banned_users' => 'banned_users#index'
  get 'banned_users/new' => 'banned_users#new', as: 'new_banned_user'
  post 'banned_users' => 'banned_users#create'
  delete 'banned_users' => 'banned_users#destroy'

  resources :families
  get 'families/page/:page' => 'families#index'
  post 'family/intolerance' => 'families#add_intolerance'
  delete 'family/intolerance' => 'families#del_intolerance'

  # resources :products
  get 'products/page/:page' => 'products#index'
  get 'products/:id/edit' => 'products#edit'
  get 'products/new' => 'products#new', as: 'new_product'
  delete 'product/:id' => 'products#destroy'
  get 'products/:id' => 'products#show'
  get 'products/:id/edit' => 'products#edit', as: 'edit_product'
  delete 'products/:id' => 'products#destroy'
  put 'products' => 'products#search'
  post 'products/intolerance' => 'products#add_intolerance'
  delete 'products/intolerance' => 'products#del_intolerance'
  # delete 'products/:id/intolerance' => 'products#del_intolerance'
  post 'migrate_txt_products' => 'products#migrate_new_products'
  post 'migrate_txt_intolerances' => 'products#migrate_txt_intolerances'
  get 'denounced_products' => 'products#denounced_products'
  post 'denounce_product' => 'products#denounce_product'
  put 'update' => 'products#update'

  
  post 'testing' => 'products#testing'
  get 'ping' => 'home#ping'



  # resources :companies

  # resources :intolerances
  ############# no borrar (son todas las rutas que otorgan los resources) ###############
  # get 'products' => 'products#index'
  # get 'products/new' => 'products#new'
  # get 'products/:id' => 'products#show'
  # get 'products/:id/edit' => 'products#edit'
  # post 'products' => 'products#create'
  # put 'products/:id' => 'products#update'
  # delete 'products/:id' => 'products#destroy'
  ############# no borrar ###############






  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     #   end
end

Rails.application.routes.draw do

  resources :comments#, only: [:show, :edit, :update, :destroy]
  get 'comments' => 'comments#index'
  get 'comments/:id' => 'comments#getcomm'
  get 'product_comments/:id' => 'comments#productcomments'
  post 'comments' => 'comments#create'
  get 'comments/new' => 'comments#new'
  put 'comments/:id/edit' => 'comments#edit'
  put 'comments/:id' => 'comments#update'
  put 'like_comment/:id' => 'comments#like_dislike'
  delete 'comments/:id' => 'comments#destroy'
  get 'denounced_comments' => 'comments#denounced_comments'


  resources :notifications
  post 'sendemail' => 'notifications#create'
  get 'messages' => 'notifications#getmsg'
  delete 'messages/:id' => 'notifications#destroy'
  
  devise_for :users, path: '', controllers: { registrations: "users/registrations", sessions: "users/sessions", omniauth_callbacks: 'omniauth_callbacks'}
  root 'home#index'

  devise_scope :user do
    post 'register' => 'users/registrations#create'
    post 'social' => 'users/registrations#social'
    get 'delete_avatar' => 'users/registrations#delete_avatar'
    get 'users/page/:page' => 'users/registrations#users'
    get 'user/:id' => 'users/registrations#user'
    delete 'user/:id' => 'users/registrations#user_delete'
    get 'user' => 'users/sessions#user_actual'
    put 'user' => 'users/registrations#user_edit'
  end

  # resources :banned_users
  get 'banned_users' => 'banned_users#index'
  get 'banned_users/new' => 'banned_users#new', as: 'new_banned_user'
  post 'banned_users' => 'banned_users#create'
  delete 'banned_users/:id' => 'banned_users#destroy'

  resources :families
  get 'families/page/:page' => 'families#index'
  post 'family/intolerance' => 'families#add_intolerance'
  delete 'family/intolerance' => 'families#del_intolerance'

  # resources :products
  get 'products/page/:page' => 'products#index'
  get 'products/new' => 'products#new', as: 'new_product'
  post 'product/new' => 'products#create'
  delete 'product/:id' => 'products#destroy'
  get 'products/:id' => 'products#show'
  put 'products/:id/editar' => 'products#update'
  get 'products/:id/edit' => 'products#edit', as: 'edit_product'
  put 'products' => 'products#search'
  post 'products/intolerance' => 'products#add_intolerance'
  delete 'products/intolerance' => 'products#del_intolerance'
  # delete 'products/:id/intolerance' => 'products#del_intolerance'
  post 'migrate_txt_products' => 'products#migrate_new_products'
  post 'migrate_txt_intolerances' => 'products#migrate_txt_intolerances'
  put 'recomended_products' => 'products#recomended_products'
  get 'suggested_products' => 'products#suggested_products'
  get 'denounced_products' => 'products#denounced_products'
  put 'recommend_product/:id' => 'products#recommend_product'
  post 'suggest_product' => 'products#suggest_product'
  post 'denounce_product' => 'products#denounce_product'
  put 'update' => 'products#update'
  put 'ask_database' => 'products#ask_database'
  put 'download_database' => 'products#download_database'
  # post 'recommend/:id' => 'products#recommend'
  get 'get_recommended' => 'products#get_recommended'

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

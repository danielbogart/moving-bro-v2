Rails.application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations" }
  
  get 'home/index'
  get 'user_groups/index'
  #must go above resources :user_groups otherwise it calls get user_groups/:id
  get 'user_groups/search' => 'user_groups#search'

  post 'user_groups/sent_emails' => 'user_groups#send_invite_to_members'

  get 'user_groups/join_user_group/:group_name' => 'user_groups#join_user_group'

  get 'user_groups/:token/sign_up' => 'user_groups#join_by_email'

  get 'user_groups/:token/invite_members' => 'user_groups#invite_members'

  authenticated :user do
     resources :items
     resources :user_groups
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  post 'user_groups/:group_name' => 'user_groups#update_user_group_items'

  get 'user_groups/:group_name/taken_items' => 'user_groups#taken_items'

  post 'user_groups/:group_name/taken_items' => 'user_groups#update_taken_items'

  put 'user_groups' => 'user_groups#update'

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
  #     resources :products
  #   end
end

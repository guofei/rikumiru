Rails.application.routes.draw do
  resources :keyword_indices

  devise_for :users

  get 'users/set_admin_cookie'

  resources :categories
  resources :hot_keywords
  resources :mailmagas

  resources :companies do
    get 'chart_data', on: :member
    get 'emotion_chart', on: :member
    post 'topword', on: :member
  end
  resources :index, controller: 'sub_indices'

  resources :comments

  resources :tweets do
    put 'vote', on: :member
    post 'bayesfilter', on: :collection
    post 'unuseful', on: :collection
    post 'removeall', on: :collection
    get 'userfilter', on: :collection
  end

  resources :keywords, path: 'topics' do
    get 'chart_data', on: :member
  end

  resources :searches, only: [:index], path: 'search'

  get 'static_pages/home'
  post 'static_pages/update'
  get 'static_pages/chart_data'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'static_pages#home'

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

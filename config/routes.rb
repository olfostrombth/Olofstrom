Rails.application.routes.draw do

  get 'sessions/create' => 'sessions#create'

  get 'sessions/destroy' => 'sessions#destroy'

  root 'categories#index'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'login', to: 'sessions#login', as: 'login'
  get "/modul/:category_name" => "categories#show", :as => :category
  get "/modul/:category_name/edit" => "categories#edit", :as => :edit_caturl
  put "/modul/:category_name" => "categories#update"
  patch "/modul/:category_name" => "categories#update"
  delete "/modul/:category_name" => "categories#destroy"

  get "/modul/:category_name/:step_name" => "steps#show", :as => :step
  get "/modul/:category_name/:step_name/edit" => "steps#edit", :as => :edit_step
  put "/modul/:category_name/:step_name" => "steps#update"
  patch "/modul/:category_name/:step_name" => "steps#update"
  delete "/modul/:category_name/:step_name" => "steps#destroy"
  get "/modul/:category_name/step/new" => "steps#new"

  resources :sessions, only: [:create, :destroy]

  resources :quizzes

  resources :comments

  resources :questions

  resources :assignments

  resources :guides

  resources :videos

  resources :steps, only: [:create, :index]

  resources :examinations

  resources :categories, only: [:create, :index, :new]

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
  #     resources :products
  #   end
end

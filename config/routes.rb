Rails.application.routes.draw do

  #mount Ckeditor::Engine => '/ckeditor'
  get 'sessions/create' => 'sessions#create'

  get 'sessions/destroy' => 'sessions#destroy'
  get 'profile/:name_url' => 'sessions#show', :as => :user
  post 'sessions/show/:id' => 'sessions#update'
  patch 'profile/:id' => 'sessions#update'
  put 'profile/:id' => 'sessions#update'
  get 'sessions/show/:id/del' => 'sessions#delUser', :as => :user_del
  post 'steps/update_row_order' => 'steps#update_row_order', :as => :update_row_order_substeps
  post 'steps/update_completion' => 'steps#update_completion', :as => :update_completion
  post 'sessions/importUsers' => 'sessions#importUsers', :as => :import_users
  get '/search' => 'sessions#search', :as => :search
  get '/autocomplete' => 'sessions#autocomplete', :as => :autocomplete

  root 'categories#index'
  get '/admin', to: 'sessions#admin', :as => :admin
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'login', to: 'sessions#login', as: 'login'
  get "/modul/:category_name" => "categories#show", :as => :category
  get "/modul/:category_name/edit" => "categories#edit", :as => :edit_caturl
  put "/modul/:category_name" => "categories#update"
  patch "/modul/:category_name" => "categories#update"
  delete "/modul/:category_name" => "categories#destroy", :as => :delete_category

  get "/modul/:category_name/:step_name" => "steps#show", :as => :step
  get "/modul/:category_name/:step_name/edit" => "steps#edit", :as => :edit_step
  put "/modul/:category_name/:step_name" => "steps#update"
  patch "/modul/:category_name/:step_name" => "steps#update"
  delete "/modul/:category_name/:step_name" => "steps#destroy", :as => :delete_step
  get "/modul/:category_name/step/new" => "steps#new"

  get "/videos/:video_name" => "videos#show", :as => :video
  get "/videos/:video_name/edit" => "videos#edit", :as => :edit_video
  put "/videos/:video_name" => "videos#update"
  patch "/videos/:video_name" => "videos#update"
  delete "/videos/:video_name" => "videos#destroy", :as => :delete_video
  get "/videos/new" => "videos#new"

  get "/quizzes/:quiz_name" => "quizzes#show", :as => :quiz
  get "/quizzes/:quiz_name/edit" => "quizzes#edit", :as => :edit_quiz
  put "/quizzes/:quiz_name" => "quizzes#update"
  patch "/quizzes/:quiz_name" => "quizzes#update"
  delete "/quizzes/:quiz_name" => "quizzes#destroy", :as => :delete_quiz
  get "/quizzes/new" => "quizzes#new"

  get "/guides/:guide_name" => "guides#show", :as => :guide
  get "/guides/:guide_name/edit" => "guides#edit", :as => :edit_guide
  put "/guides/:guide_name" => "guides#update"
  patch "/guides/:guide_name" => "guides#update"
  delete "/guides/:guide_name" => "guides#destroy", :as => :delete_guide
  get "/guides/new" => "guides#new"

  get "/assignments/:assignment_name" => "assignments#show", :as => :assignment
  get "/assignments/:assignment_name/edit" => "assignments#edit", :as => :edit_assignment
  put "/assignments/:assignment_name" => "assignments#update"
  patch "/assignments/:assignment_name" => "assignments#update"
  delete "/assignments/:assignment_name" => "assignments#destroy", :as => :delete_assignment
  get "/assignments/new" => "assignments#new"

  get "/questions/:question_name" => "questions#show", :as => :question
  get "/questions/:question_name/edit" => "questions#edit", :as => :edit_question
  put "/questions/:question_name" => "questions#update"
  patch "/questions/:question_name" => "questions#update"
  delete "/questions/:question_name" => "questions#destroy", :as => :delete_question
  get "/questions/new" => "quizzes#new"

  put "/comments" => "comments#update"
  patch "/comments" => "comments#update"


  resources :sessions
  #, only: [:create, :destroy]


  resources :comments, only: [:edit, :create, :update, :destroy]

  resources :steps, only: [:create, :index]

  resources :videos, only: [:create, :index]

  resources :quizzes, only: [:create, :index]

  resources :guides, only: [:create, :index]

  resources :assignments, only: [:create, :index]

  resources :questions, only: [:create, :index]

  resources :examinations, only: [:edit, :create, :update, :destroy]

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

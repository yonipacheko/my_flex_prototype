Myflix::Application.routes.draw do

  root to: 'pages#front'

  get 'ui(/:action)', controller: 'ui'

  get '/home', to: 'videos#index'
  resources :videos do
    collection do
      post '/search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  resources :categories, only: [:new, :create, :show]

  resources :queue_items, only: [:create, :destroy]
  get 'my_queue', to: 'queue_items#index'
  post 'update_queue', to: 'queue_items#update_queue'

  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'

  resources :users, only: [:create, :show]
  get 'people', to: 'relationships#index'
  resources :relationships, only: [:destroy]

  resources :sessions, only: [:create]




end

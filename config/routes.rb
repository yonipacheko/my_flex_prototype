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
  resources :relationships, only: [:destroy, :create]

  resources :sessions, only: [:create]

  #We have a virtual resourse below!!
  get 'forgot_password', to: 'forgot_passwords#new'
  resources :forgot_passwords, only: [:create]
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirmation'
  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'password_resets#expired_token'




end

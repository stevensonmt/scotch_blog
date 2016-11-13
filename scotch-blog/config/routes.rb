Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'posts#landing_page'
  get '/index', to: 'posts#index'
  # get '/login', to: 'sessions#new'
  # post '/login', to: 'sessions#create'
  # delete '/logout', to 'sessions#destroy'

  resources :posts
  resources :authors
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :posts, only: [:create, :destroy]

end

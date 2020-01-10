Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'posts#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'profile', to: 'sessions#show'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  resources :users, only: ['show']
  resources :posts
end

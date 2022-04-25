Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  root 'tasks#index'
  resources :tasks
  resources :categories
  resources :users
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end

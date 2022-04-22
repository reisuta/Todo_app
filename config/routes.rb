Rails.application.routes.draw do
  get 'users/new'
  root 'tasks#index'
  resources :tasks
  resources :categories
end

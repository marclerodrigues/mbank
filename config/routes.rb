Rails.application.routes.draw do
  resources :users, only: [:create]
  resources :transfers, only: [:create]
  resources :balance, only: [:show]
end

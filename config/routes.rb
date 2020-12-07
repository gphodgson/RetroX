Rails.application.routes.draw do
  resources :orders, only: %i[show new create]
  # get "checkout", to: "checkout#index", as: "checkout"

  post "cart/:id", to: "cart#create", as: "cart_create"
  post "cart/delete/:id", to: "cart#destroy", as: "cart_delete"
  post "cart/update/:id", to: "cart#update", as: "cart_update"

  resources :catagories, only: [:show]
  resources :addresses, only: %i[new create]

  resources :sessions, only: %i[new create destroy]
  get "logout", to: "sessions#destroy", as: "logout"

  resources :users, only: %i[show new create]

  resources :products, only: %i[index show]
  resources :checkout, only: [:index]

  root to: "home#index"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

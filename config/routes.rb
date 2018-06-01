Rails.application.routes.draw do
  resources :achievements
  resources :users
  devise_for :users

  get "profile/index"
  get "profile", to: "profile#index"
  get "profile/:id", to: "profile#index"

  # get "users", to: "users#index"
  # get "users/:id", to: "users#show"
  # get "users/new", to: "users#new"
  # get "users/:id/edit", to: "users#edit"
  # post "users", to: "users#create"
  # delete "users/:id", to: "users#destroy"
  # patch "users/:id", to: "users#update"

  root "profile#index"
end

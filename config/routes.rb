Rails.application.routes.draw do
  devise_for :users

  resources :achievements
  resources :users

  get "profile/index"
  get "profile", to: "profile#index"
  get "profile/:id", to: "profile#index"

  root "profile#index"
end

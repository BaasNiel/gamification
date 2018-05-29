Rails.application.routes.draw do
  devise_for :users

  get "home/index"
  get "home", to: "home#index"
  get "home/:id", to: "home#index"

  root "home#index"
end

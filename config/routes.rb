Rails.application.routes.draw do
  resources :achievements
  devise_for :users

  get "profile/index"
  get "profile", to: "profile#index"
  get "profile/:id", to: "profile#index"

  root "profile#index"
end

Rails.application.routes.draw do
  devise_for :users, controllers: {
  invitations: "invitations"
}

  resources :achievements
  resources :users

  get "profile/index"
  get "profile", to: "profile#index"
  get "profile/:id", to: "profile#index"

  get "users/:id/assign_achievements", to: "achievements#assign_index", as: :assign_index
  post "users/assign_achievements", to: "achievements#assign_create", as: :assign_create

  root "profile#index"
end

require 'sidekiq/web'

Rails.application.routes.draw do
  resources :teams
  devise_for :users, controllers: {
    invitations: "invitations"
  }

  resources :achievements
  resources :users
  resources :pomodoros

  get "profile/index"
  get "profile", to: "profile#index"
  get "profile/:id", to: "profile#index"

  get "users/:id/assign_achievements", to: "achievements#assign_index", as: :assign_index
  post "users/assign_achievements", to: "achievements#assign_create", as: :assign_create

  post "pomodoros/:id/stop"   => "pomodoros#stop",   as: :pomodoros_stop
  post "pomodoros/:id/pause"  => "pomodoros#pause",  as: :pomodoros_pause
  post "pomodoros/:id/resume" => "pomodoros#resume", as: :pomodoros_resume

  get "user_achievements", to: "user_achievements#index"
  get "user_achievements/:id", to: "user_achievements#index"

  get "team/index"
  get "team", to: "team#index"

  root "profile#index"

  mount Sidekiq::Web => '/sidekiq'
end

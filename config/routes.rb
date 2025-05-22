Rails.application.routes.draw do
  # Devise routes for user auth
  devise_for :users

  # Set root path to home page
  root "home#index"

  # Standard RESTful routes for core models
  resources :photos
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :follow_requests, only: [:create, :update, :destroy]

  # Explicit routes for user-facing views
  get "/users" => "users#index", as: :users
  get "/users/:username" => "users#show", as: :user_profile
  get "/users/:username/feed" => "users#feed", as: :user_feed
  get "/users/:username/discover" => "users#discover", as: :user_discover
  get "/users/:username/liked_photos" => "users#liked_photos", as: :user_liked_photos
end  # ← THIS "end" is required

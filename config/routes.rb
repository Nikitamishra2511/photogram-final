Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  resources :photos
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :follow_requests, only: [:create, :update, :destroy]

  get "/users" => "users#index", as: :users
  get "/users/:username" => "users#show", as: :user_profile
  get "/users/:username/feed" => "users#feed", as: :user_feed
  get "/users/:username/discover" => "users#discover", as: :user_discover
  get "/users/:username/liked_photos" => "users#liked_photos", as: :user_liked_photos
end

require 'sidekiq/web'

Rails.application.routes.draw do
  resources :chats
  resources :users
  get "signup" => "users#new"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resource :session, only: [:new, :create, :destroy]
  get "signin" => "sessions#new"
  # Defines the root path route ("/")
  root "chats#index"
  resources :chat_messages, only: [:create]
  mount Sidekiq::Web => "/sidekiq"
end

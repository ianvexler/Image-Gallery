Rails.application.routes.draw do
  resources :galleries
  resources :images
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: "main#index"

  # Sign up routes
  get "sign_up", to: "users#new"
  post "sign_up", to: "users#create"

  # Login routes
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"

  # Logout routes
  post "logout", to: "sessions#delete"

  # Gallery routes
  get "galleries", to: "gallery#index"

end

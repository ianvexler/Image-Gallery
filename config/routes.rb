Rails.application.routes.draw do
  resources :images, except: [:index]
  resources :users, except: [:index]
  resources :sessions
  resources :galleries
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: "galleries#index"

  get "search", to: "search#index"

  # Sign up routes
  get "sign_up", to: "users#new"
  post "sign_up", to: "users#create"

  # Login routes
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"

  # Logout routes
  post "logout", to: "sessions#delete"
  patch "logout", to: "sessions#delete"

  get "error", to: "error#index"
  get "error_access", to: "error#access"

  # In case incorrect route is given
  get '*path', to: "error#index"
end

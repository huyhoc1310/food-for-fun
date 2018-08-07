Rails.application.routes.draw do
  root "static_pages#home"
  
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  namespace :admin do
    resources :restaurants, only: :index
  end
  namespace :manager do
    resources :restaurants, except: :destroy
  end
  resources :restaurants do
    resources :suggests
  end

  resources :foods
end

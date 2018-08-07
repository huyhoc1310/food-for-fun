Rails.application.routes.draw do
  post "/rate", to: "rater#create", as: "rate"
  root "static_pages#home"

  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users do
    member do
      get :following
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  namespace :admin do
    resources :restaurants, only: :index
    resources :users, except: :show
  end

  namespace :manager do
    resources :restaurants, except: :destroy
    resources :orders, only: [:index, :update] do
      patch "/cancel_order", to: "orders#cancel_order"
    end
    get "/all_orders", to: "orders#all_orders"
    resources :menus, only: [:show, :edit] do
      patch "/delete_food", to: "menus#delete_food"
    end
    resources :notifications, only: [:index]
  end

  namespace :user do
    resources :orders, only: [:index, :update] do
      patch "/confirm_receive", to: "orders#confirm_receive"
    end
  end

  resources :restaurants do
    get "/restaurant_foods", to: "restaurants#restaurant_foods"
    resources :suggests
    member do
      get :followers
    end
    resources :categories
  end

  resources :foods do
    post "/delete_food", to: "foods#update_status"
    resources :images
    resources :comments do
      get :reply
    end
  end

  resources :relationships, only: [:create, :destroy]

  get "/search", to: "search#index"
  get "/restaurants/:city", to: "restaurants#index"
  get "/foods/:category", to: "foods#index"
  resources :order_details
end

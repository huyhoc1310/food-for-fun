Rails.application.routes.draw do
  root "static_pages#home"
  namespace :admin do
    resources :restaurants, except: [:show]
  end
end

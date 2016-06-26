Rails.application.routes.draw do
  resources :thermostats

  devise_for :users
  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end
  root 'home#index'
end

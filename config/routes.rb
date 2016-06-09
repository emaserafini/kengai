Rails.application.routes.draw do
  resources :thermostats
  root 'home#index'
  devise_for :users
end

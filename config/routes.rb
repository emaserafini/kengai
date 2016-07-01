Rails.application.routes.draw do
  UUID_REGEXP = /[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/

  scope module: 'application' do
    constraints(uuid: UUID_REGEXP) do
      resources :thermostats, param: :uuid
    end

    devise_for :users, module: 'devise'
    authenticated :user do
      root 'dashboard#index', as: :authenticated_root
    end
    root 'home#index'
  end

  namespace :api do
    constraints(uuid: UUID_REGEXP) do
      resources :thermostats, param: :uuid, only: :show
    end
  end
end

Rails.application.routes.draw do
  resource :dashboard, only: [:show]

  authenticated :user, lambda { |user| user.has_role?(:admin) } do
    root to: 'admins/dashboards#show'
  end

  authenticated :user do
    root to: 'dashboards#show'
  end

  root to: 'welcome#index'
  get 'welcome/index'

  resources :redemptions, only: :create

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :deeds, only: [:new, :create]

  namespace :admins do
    resource :dashboard, only: [:show]
    resources 'prizes', only: [:new, :create, :edit, :update]
    resources 'stations', only: [:new, :create]
    resources 'users', only: [:index]
    resources 'admins', only: [:index, :new, :create, :destroy]
    resources :users do
      resources :strikes, only: :create
    end
  end

  namespace :api do
    namespace :geojson do
      namespace :v1 do
        resources 'stations', only: [:index]
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

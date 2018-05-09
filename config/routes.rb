Rails.application.routes.draw do
  resource :dashboard, only: [:show]

  resources :prizes, only: [:index]

  root to: 'welcome#index'
  get 'welcome/index'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :deeds, only: [:new, :create]

  namespace :admins do
    resource :dashboard, only: [:show]
    resources 'prizes', only: [:new, :create, :edit, :update]
    resources 'stations', only: [:new, :create]
    resources 'admins', only: [:index, :new, :create, :destroy]
  end

  namespace :api do
    namespace :geojson do
      namespace :v1 do
        resources 'stations', only: [:index]
      end
    end
  end

  get 'dashboard', to: 'dashboards#show', as: :user_root

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


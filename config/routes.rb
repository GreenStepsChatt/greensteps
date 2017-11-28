Rails.application.routes.draw do
  get 'dashboards/show'

  root to: 'welcome#index'
  get 'welcome/index'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :deeds, only: [:new, :create]

  get 'dashboard', to: 'dashboards#show', as: :user_root

  namespace :admin do
    get 'dashboards/show'
    resources 'prizes', only: [:new, :create]
    resources 'admins', only: [:index]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

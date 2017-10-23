Rails.application.routes.draw do
  resource 'prizes', only: [:new, :create]

  get 'dashboards/show'

  root to: 'welcome#index'
  get 'welcome/index'

  devise_for :users

  resources :deeds, only: [:new, :create]

  get 'dashboard', to: 'dashboards#show', as: :user_root

  namespace :admin do
    get 'dashboards/show'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

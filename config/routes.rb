Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: :login
  end
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :spaces, except: [:new, :create] do
    resources :bookings, only: [:new, :create ]
  end
  resources :venues do
    resources :spaces, only: [:new, :create]
  end
  resources :bookings, only: [:index, :destroy]
  get 'dashboard', to: 'dashboards#show', as: :dashboard
end

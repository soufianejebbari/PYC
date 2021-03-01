Rails.application.routes.draw do
  get 'reviews/index'
  get 'reviews/new'
  get 'reviews/create'
  root to: 'pages#home'

  devise_for :users,
              path: '',
              path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile'}
  resources :users, only: :show do
    resources :boats, only: [:index]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :cruises do
    resources :bookings, only: [:index, :show, :new, :create]
    resources :reviews, only: [:index, :new, :create ]
  end

  resources :boats, only:  [:new, :create, :update, :edit]
  get 'dashboard', to: 'dashboards#dashboard'

end


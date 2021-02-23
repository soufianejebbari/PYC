Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :cruises do
    resources :bookings, only: [:index, :show, :new, :create]
  end

  resources :boats, only: [:new, :create, :update, :destroy]
end

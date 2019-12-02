Rails.application.routes.draw do
  root to: 'home#index'
  resources :manufacturers, only: [:index, :show, :new, :create]
  resources :subsidiaries, only: [:index, :show, :new, :create]
  resources :car_categories, only: [:index, :show, :new, :create]
end

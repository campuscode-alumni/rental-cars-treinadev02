Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  
  resources :manufacturers 
  resources :subsidiaries 
  resources :car_categories
  resources :clients
  resources :users, only: [:index, :show, :create, :new, :edit, :update]
  resources :car_models, only: [:index, :show, :create, :new, :edit, :update]
  resources :cars, only: [:index, :show, :create, :new, :edit, :update]
  resources :rentals , only: [:index, :show, :create, :new, :edit, :update] do
    get 'search', on: :collection
    post 'start', on: :member
  end
end

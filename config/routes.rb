Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  
  resources :manufacturers 
  resources :subsidiaries 
  resources :car_categories
  resources :clients
  resources :car_models
  resources :cars
  resources :rentals do
    get 'search', on: :collection
    post 'start', on: :member
  end
end

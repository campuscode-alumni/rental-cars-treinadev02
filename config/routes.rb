Rails.application.routes.draw do
  root to: 'home#index'
  
  resources :manufacturers
  resources :subsidiaries
  resources :car_categories
  resources :clients
end

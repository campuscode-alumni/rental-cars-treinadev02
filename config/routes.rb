Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  
  resources :manufacturers, :subsidiaries, :car_categories,:clients
  resources :car_models, :cars, :rentals, only: [:index, :show, :create, :new, :edit, :update]

end

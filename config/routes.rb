Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  
  resources :manufacturers, :subsidiaries, :car_categories,:clients
  resources :car_models, :cars, only: [:index, :show, :create, :new, :edit, :update]
  resources :rentals , only: [:index, :show, :create, :new, :edit, :update] do
    get 'search', on: :collection
  end
end

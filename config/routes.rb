Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :manufacturers, only: [:index, :show, :new, :create, :edit, :update]
  resources :subsidiaries, only: [:index, :show, :new, :create, :edit, :update]
  resources :car_categories, only: [:index, :show, :new, :create, :edit, :update]
  resources :clients, only: [:index, :show, :new, :create]
  resources :car_models, only: [:index, :new, :create, :show]
  resources :rentals, only: [:index, :new, :create, :show] do
    get 'search', on: :collection
  end
end

Rails.application.routes.draw do
  root to: 'home#index'
  resources :manufacturers, olny: [:index, :show, :new, :create]
  resources :subsidiaries, olny: [:index, :show, :new, :create]
  resources :car_categories, olny: [:index, :show, :new, :create]
end

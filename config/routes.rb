Rails.application.routes.draw do
  root to: 'home#index'
  resources :manufacturers, olny: [:index, :show, :new, :create, :edit, :update]
  resources :subsidiaries, olny: [:index, :show, :new, :create, :edit, :update]
  resources :car_categories, olny: [:index, :show, :new, :create, :edit, :update]
end

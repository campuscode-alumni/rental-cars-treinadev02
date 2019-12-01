Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

resources :manufacturers, only: [:index, :show, :new, :create]
resources :subsidiaries, only: [:index, :show, :new, :create]
resources :car_categories, only: [:index, :show, :new, :create]

root 'home#index'
end

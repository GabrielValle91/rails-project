Rails.application.routes.draw do
  resources :locations, only: [:show, :new, :create, :edit, :update]
  resources :drivers, only: [:show, :new, :create, :edit, :update]
  resources :shipments, only: [:show, :new, :create, :edit, :update]
  resources :items, only: [:show, :new, :create, :edit, :update]
  resources :clients, only: [:show, :new, :create, :edit, :update]
  resources :users, only: [:show, :new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  resources :locations, only: [:index, :show, :new, :create, :edit, :update]
  resources :drivers, only: [:index, :show, :new, :create, :edit, :update]
  resources :shipments, only: [:index, :show, :new, :create, :edit, :update]
  resources :items, only: [:index, :show, :new, :create, :edit, :update]
  resources :clients, only: [:index, :show, :new, :create, :edit, :update]
  resources :users, only: [:show, :new, :create]

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/logout', to: 'sessions#logout'
end

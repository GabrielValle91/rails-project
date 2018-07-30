Rails.application.routes.draw do
  root 'application#homepage'

  resources :locations, only: [:index, :show, :new, :create, :edit, :update]

  resources :drivers, only: [:index, :show, :new, :create, :edit, :update]

  resources :shipments, only: [:index, :show, :new, :create, :edit, :update] do
    resources :locations, only: [:new, :create]
  end

  resources :items, only: [:index, :show, :new, :create, :edit, :update]

  resources :clients, only: [:index, :show, :new, :create, :edit, :update] do
    resources :shipments, only: [:index, :show, :new, :create, :edit, :update]
    resources :items, only: [:index, :show, :new, :create, :edit, :update]
  end

  resources :users, only: [:show, :new, :create] do
    resources :clients, only: [:index, :show, :new, :create, :edit, :update]
    resources :shipments, only: [:index, :show, :new, :create, :edit, :update]
    resources :items, only: [:index, :show, :new, :create, :edit, :update]
    resources :drivers, only: [:index, :show, :new, :create, :edit, :update]
  end

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/logout', to: 'sessions#logout'
end

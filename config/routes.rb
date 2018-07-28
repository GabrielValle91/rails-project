Rails.application.routes.draw do
  resources :locations
  resources :drivers
  resources :shipments
  resources :items
  resources :clients
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

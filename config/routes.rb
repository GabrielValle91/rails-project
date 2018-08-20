Rails.application.routes.draw do
  resources :dispatches
  root 'application#homepage'

  resources :locations, except: [:delete]

  resources :drivers, except: [:delete]

  resources :shipments, except: [:delete] do
    resources :locations, only: [:new, :create]
  end

  resources :items, except: [:delete]

  resources :clients, except: [:delete] do
    resources :shipments, except: [:delete]
    resources :items, except: [:delete]
  end

  resources :users, only: [:show, :new, :create, :index] do
    resources :clients, except: [:delete]do
      resources :items, except: [:delete]
    end
    resources :shipments, except: [:delete]
    resources :items, except: [:delete]
    resources :drivers, except: [:delete]
    resources :locations, except: [:delete]
  end

  resources :dispatch, only: [:index]

  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/logout', to: 'sessions#logout'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/dispatch/assignedshipments/:date', to: 'dispatch#assignedshipments'
  get '/dispatch/unassignedshipments', to: 'dispatch#unassignedshipments'
end

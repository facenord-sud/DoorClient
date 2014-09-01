DoorClient::Application.routes.draw do
  concern :put do
    put on: :collection, action: :update, as: :put
    post on: :collection, action: :pub, as: :pub
    post '/notify', on: :collection, action: :notify, as: :notify
  end

  root to: 'doors#index'

  resources :doors do
      resources :locks, only: [:show, :index] do
        concerns :put
      end
      resources :opens, only: [:show, :index] do
        concerns :put
      end
  end
end

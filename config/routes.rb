DoorClient::Application.routes.draw do

  concern :put do
    put on: :collection, action: :update, as: :put
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
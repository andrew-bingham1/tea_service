Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :customer_subscriptions, only: [:create]
      delete '/customer_subscriptions', to: 'customer_subscriptions#destroy'
      get '/customers', to: 'customers#show'
    end
  end
end

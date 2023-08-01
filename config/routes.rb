Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v0 do
      resources :customer_subscriptions, only: [:create]
      delete '/customer_subscriptions', to: 'customer_subscriptions#destroy'
    end
  end
end

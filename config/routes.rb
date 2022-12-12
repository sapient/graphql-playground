Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  mount Motor::Admin => '/motor_admin'
  resources :stocks
  resources :colors
  resources :car_models
  resources :manufacturers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

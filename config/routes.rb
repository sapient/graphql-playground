Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
  mount Motor::Admin => '/motor_admin'
  resources :stocks
  resources :colors
  resources :car_models
  resources :manufacturers

  root "stocks#index"
end

module Types
  class StockType < Types::BaseObject
    field :id, ID, null: false
    field :car_model, CarModelType, null: true
    field :color, ColorType, null: true
    field :mileage, Integer, null: true
    field :cost, Integer, null: true
    field :price, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end

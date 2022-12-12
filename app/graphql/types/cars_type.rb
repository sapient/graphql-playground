module Types
  class CarsType < Types::BaseObject
    field :manufacturer, String, null: false
    field :model, String, null: false
    field :color, String, null: false
    field :mileage, Int, null: false
    field :cost, Int, null: false
    field :price, Int, null: false
  end
end

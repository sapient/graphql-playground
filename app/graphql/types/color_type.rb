module Types
  class ColorType < Types::BaseObject
    field :id, ID, null: false
    field :full_name, String, null: true
    field :name, String, null: true
    field :metallic, Boolean, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :colors, [ColorType], null: true, description: 'Colors'
    def colors
      Color.all
    end

    field :rows, [CarsType], null: true do
      description 'Returns a pivotable list of cars'

      argument :start_row, Int, required: false
      argument :end_row, Int, required: false
      argument :row_groups, [RowGroupType], required: false
      argument :group_keys, [String], required: false
      argument :sorting, [SortType], required: false
    end

    def rows(start_row: nil, end_row: nil, row_groups: nil, group_keys: nil, sorting: nil)

      sorting.each do |s|
        ap s
      end

      order_sql = sorting.map { |s| "#{s.col_id} #{s.sort}"}.join(', ')

      Stock.joins(car_model: :manufacturer).order(order_sql).all.map do|stock|
        {
          id: stock.id,
          manufacturer: stock.car_model.manufacturer.name,
          model: stock.car_model.name,
          color: stock.color.full_name,
          mileage: stock.mileage,
          cost: stock.cost,
          price: stock.price
        }
      end
    end
  end
end

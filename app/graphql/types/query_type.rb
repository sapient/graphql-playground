module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField



    field :colors, [ColorType], null: true, description: 'Colors'
    def colors
      Color.all
    end



    field :pivot_configs, [PivotConfigType], null: true, description: 'Would return a list of Pivot queries for a customer'
    def pivot_configs
      PivotConfig.all
    end

    field :pivot_config, PivotConfigType, null: false do
      argument :id, Integer, required: true
    end
    def pivot_config(id: nil)
      PivotConfig.find(id)
    end



    ## Pivot for a specific config
    # This should load the pivot config and run its SQL, applying any configs found to the query and output
    field :untyped_pivot_for_config, String, null: true do
      description 'Returns data defined by a config'
      argument :id, Integer, required: true
      argument :pivot_args, PivotQueryType, required: false
    end
    def untyped_pivot_for_config(id:, pivot_args:)
      DataFromPivotConfig.call(id: id).to_json
    end



    field :typed_pivot_for_config, [PivotDataType], null: true do
      description 'Returns data defined by a config'
      argument :id, Integer, required: true
      argument :pivot_args, PivotQueryType, required: false
    end
    def typed_pivot_for_config(id:, pivot_args:)
      Rails.logger.ap pivot_args
      typed_data = DataFromPivotConfig.call(id: id, pivot_args: pivot_args)
      typed_data
    end



    field :rows, String, null: true do
      description 'Returns a pivotable list of cars'

      argument :start_row, Int, required: false
      argument :end_row, Int, required: false
      argument :row_groups, [RowGroupType], required: false
      argument :group_keys, [String], required: false
      argument :sorting, [SortType], required: false
    end
    def rows(*args)
      flat_data = [
        { company: 'Komati', profit: '100', fy: 2022 },
        { company: 'Komati', profit: '110', fy: 2023 },
        { company: 'Komati', profit: '130', fy: 2024 },
        { company: 'Komati', profit: '160', fy: 2025 },
        { company: 'Oranje', profit: '100', fy: 2022 },
        { company: 'Oranje', profit: '110', fy: 2023 },
        { company: 'Oranje', profit: '130', fy: 2024 },
        { company: 'Oranje', profit: '160', fy: 2025 },
      ].to_json.to_s

      # Stock.joins(car_model: :manufacturer).order(order_sql).all.map do|stock|
      #   {
      #     id: stock.id,
      #     manufacturer: stock.car_model.manufacturer.name,
      #     model: stock.car_model.name,
      #     color: stock.color.full_name,
      #     mileage: stock.mileage,
      #     cost: stock.cost,
      #     price: stock.price
      #   }
      # end
    end
  end
end

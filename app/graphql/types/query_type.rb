module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :colors, [ColorType], null: true, description: 'Colors'
    def colors
      Color.all
    end

    queries = [
       {
         query_name: :xquery,
         returns: String,
         null: true,
         arguments: [[:start_date, String, false], [:end_date, String, false], [:company_id, Int, false]],
         fields: []
       }
    ]

    field :pivot, PivotType, null: true

    queries.each do |x|
      field x[:query_name], x[:returns], null: x[:null] do
        description "Fetches #{x[:fields].join(', ')} from #{x[:query_name]}"
        x[:arguments].each do |arg|
          argument arg[0], arg[1], required: arg[3]
        end
      end
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
      Rails.logger.debug args.ai
      # order_sql = sorting.map { |s| "#{s.col_id} #{s.sort}"}.join(', ')
      #
      # flat_data = FlatDataService.call(column_list:).get_hash_table
      #
      # PivotService.new(flat_data).pivot(args).to_json # Returns a pivoted table

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

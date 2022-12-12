module Types
  class PivotQueryType < Types::BaseInputObject
    description 'Parameters for building the pivot data'

    argument :start_row, Int, required: false
    argument :end_row, Int, required: false
    argument :row_groups, [RowGroupType], required: false
    argument :group_keys, [String], required: false
    argument :sorting, [SortType], required: false
  end
end

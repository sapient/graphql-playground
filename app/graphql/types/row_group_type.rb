module Types
  class RowGroupType < Types::BaseInputObject
    argument :col_id, String, required: false
    argument :agg_func, String, required: false
  end
end

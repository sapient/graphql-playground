module Types
  class SortType < Types::BaseInputObject
    argument :col_id, String, required: false
    argument :sort, String, required: false
  end
end

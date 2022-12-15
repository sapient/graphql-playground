class PivotConfigRow < ApplicationRecord
  belongs_to :pivot_config

  enum config_type: {
    db_column: 'Column',
    db_table: 'Table',
    sql_mapping: 'SQL Mapping',
    out_mapping: 'Output Mapping'
  }
end

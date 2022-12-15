module Types
  class PivotDataType < Types::BaseObject

    # Generate field declarations from all the PivotConfigs
    PivotConfigRow.db_column.each do |col_config|
      col_config.setting.split(',').map(&:strip).each do |column|
        field column, String, null: true
      end
    end

  end
end

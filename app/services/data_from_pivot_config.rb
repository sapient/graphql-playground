class DataFromPivotConfig
  attr_accessor :pivot, :pivot_args

  def initialize(id:, pivot_args: nil)
    @pivot = PivotConfig.find(id)
    @pivot_args = pivot_args

    Rails.logger.ap pivot_args
  end

  def self.call(id:, pivot_args: nil)
    new(id: id, pivot_args: pivot_args).send(:run_query)
    # new(id: id, pivot_args: pivot_args).send(:run_arel_query)
  end

  private

  # Use Arel to build the query
  def run_arel_query(table: nil, columns: nil, groups: nil, filters: nil)
    table = 'stocks'
    columns = %w[id cost price]
    filters = [
      { column: 'cost', operator: 'gt', value: 100000 },
      { column: 'id', operator: 'eq', value: 1 }
    ]

    table = Arel::Table.new(table)

    # conditions = filters.map { |filter| table[filter[:column]].send(filter[:operator].to_s, filter[:value]) }.reduce(&:or)
    # arel_filters = filters.map do |filter|
    #   table[filter[:column]].send(filter[:operator].to_s, filter[:value])
    # end
    query = table.project(*columns).group(*groups)

    results = ActiveRecord::Base.connection.exec_query(query.to_sql)
    results.to_a
  end

  def run_query
    sql = apply_db_columns(pivot.query)
    sql = apply_mappings(sql)
    sql = apply_groups(sql)
    sql = apply_sorting(sql)

    results = ActiveRecord::Base.connection.exec_query(sql)
    results.to_a
  end

  # Check if the sql string contains a * in the select clause, if it does, and there are PivotConfigRows with the
  # config_type of db_column, then replace the * with the db_columns, otherwise do nothing
  def apply_db_columns(sql)
    return sql unless sql.match(/\*/)

    if pivot.pivot_config_rows.db_column.first.blank?
      table_name = sql.match(/from\s+(\w+)/i)[1]
      columns = get_columns(table_name).join(', ')
    else
      columns = pivot.pivot_config_rows.db_column.first.setting
    end

    sql.gsub(/\*/, columns)
  end

  # Gets the columns from a table
  def get_columns(table_name)
    ActiveRecord::Base.connection.columns(table_name).map(&:name)
  end

  # This needs to be waaay more intelligent, we can either split the query into a select and a from, and only apply this
  # to the select, or we can split the query into sections in the config.
  def apply_mappings(sql)
    select_clause, from_clause = sql.split(/from/i)

    pivot.pivot_config_rows.sql_mapping.each do |row|
      original, replacement = row.setting.split(':')
      select_clause.gsub!(original, "#{original} AS #{replacement}")
    end
    [select_clause, from_clause].join(' FROM ')
  end

  def apply_sorting(sql)
    if pivot_args&.dig(:sorting).present?
      sql += " ORDER BY "
      clauses = []
      pivot_args[:sorting].each do |sort|
        clauses << " #{sort[:col_id]} #{sort[:sort]}"
      end
      sql += clauses.join(", ")
    end
    sql
  end

  # Apply groupings to the query if there are any
  def apply_groups(sql)
    sql
  end
end

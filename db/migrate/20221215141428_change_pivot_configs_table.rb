class ChangePivotConfigsTable < ActiveRecord::Migration[7.0]
  def change
    change_column :pivot_configs, :query, :string
  end
end

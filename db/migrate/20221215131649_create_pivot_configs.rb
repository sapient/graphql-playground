class CreatePivotConfigs < ActiveRecord::Migration[7.0]
  def change
    create_table :pivot_configs do |t|
      t.string :name
      t.string :description
      t.string :query

      t.timestamps
    end
  end
end

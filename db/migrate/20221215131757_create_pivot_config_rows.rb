class CreatePivotConfigRows < ActiveRecord::Migration[7.0]
  def change
    create_table :pivot_config_rows do |t|
      t.string :pivot_config_id
      t.string :config_type
      t.string :setting

      t.timestamps
    end
  end
end

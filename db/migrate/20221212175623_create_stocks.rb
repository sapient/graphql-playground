class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.integer :car_model_id
      t.integer :color_id
      t.integer :milage
      t.integer :cost
      t.integer :price

      t.timestamps
    end
  end
end

class CreateColors < ActiveRecord::Migration[7.0]
  def change
    create_table :colors do |t|
      t.string :name
      t.boolean :metallic

      t.timestamps
    end
  end
end

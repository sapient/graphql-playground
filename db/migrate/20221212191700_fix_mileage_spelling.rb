class FixMileageSpelling < ActiveRecord::Migration[7.0]
  def change
    rename_column :stocks, :milage, :mileage
  end
end

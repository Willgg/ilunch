class AddColumnsToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :date, :date
    add_column :products, :stock, :integer, default: 0, null: false
  end
end

class RemoveStreetFromOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :street
    remove_column :orders, :post_code
    remove_column :orders, :country
  end
end

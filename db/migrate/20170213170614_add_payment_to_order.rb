class AddPaymentToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :payment, :json
  end
end

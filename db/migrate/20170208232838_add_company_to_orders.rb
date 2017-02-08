class AddCompanyToOrders < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :company, foreign_key: true
  end
end

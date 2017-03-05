class RemoveCompanyFromOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :company_id
  end
end

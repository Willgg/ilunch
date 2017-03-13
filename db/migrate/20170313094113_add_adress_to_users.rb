class AddAdressToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :street, :string
    add_column :users, :post_code, :string
    add_column :users, :city, :string
  end
end

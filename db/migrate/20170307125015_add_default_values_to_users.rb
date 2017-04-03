class AddDefaultValuesToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :optin, :boolean, default: false
  end
end

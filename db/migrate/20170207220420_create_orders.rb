class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :street
      t.string :post_code
      t.string :country
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

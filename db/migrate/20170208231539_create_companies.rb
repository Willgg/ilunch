class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :street
      t.string :post_code
      t.string :delivery_time

      t.timestamps
    end
  end
end

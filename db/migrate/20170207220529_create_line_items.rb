class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.references :order, foreign_key: true
      t.integer :quantity
      t.integer :product_id

      t.timestamps
    end
  end
end

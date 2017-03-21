class CreateMenuItems < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_items do |t|
      t.references :product
      t.references :menu
      t.integer :quantity
      t.integer :price_cents

      t.timestamps
    end
  end
end

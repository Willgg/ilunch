class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      t.string :title
      t.integer :main
      t.integer :dessert
      t.integer :drink

      t.timestamps
    end
  end
end

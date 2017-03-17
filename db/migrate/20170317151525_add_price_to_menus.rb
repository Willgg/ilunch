class AddPriceToMenus < ActiveRecord::Migration[5.0]
  def change
    add_monetize :menus, :price, currency: { present: false }
  end
end

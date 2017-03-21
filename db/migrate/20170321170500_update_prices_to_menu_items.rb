class UpdatePricesToMenuItems < ActiveRecord::Migration[5.0]
  def change
    change_column :menu_items, :price_cents, :integer, default: 0, null: false
  end
end

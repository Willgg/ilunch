class AddPriceToLineItems < ActiveRecord::Migration[5.0]
  def change
    add_monetize :line_items, :price, currency: { present: false }
  end
end

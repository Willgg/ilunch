class AddMenuToLineItems < ActiveRecord::Migration[5.0]
  def change
    add_reference :line_items, :menu, foreign_key: true
  end
end

class AddReferenceToMenus < ActiveRecord::Migration[5.0]
  def change
    add_reference :menus, :menu, foreign_key: true
  end
end

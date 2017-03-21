class RemoveMenuIdFromMenus < ActiveRecord::Migration[5.0]
  def change
    remove_reference :menus, :menu
  end
end

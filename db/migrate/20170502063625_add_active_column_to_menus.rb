class AddActiveColumnToMenus < ActiveRecord::Migration[5.0]
  def change
    add_column :menus, :active, :boolean, default: true, allow_nil: false
  end
end

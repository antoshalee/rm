class AddSubmenuToPages < ActiveRecord::Migration
  def change
    add_column :pages, :submenu, :text
  end
end

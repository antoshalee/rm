class AddSidebarIdToSidebarItems < ActiveRecord::Migration
  def change
    add_column :sidebar_items, :sidebar_id, :integer
    add_index :sidebar_items, :sidebar_id
  end
end

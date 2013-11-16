class RemoveInsertIdFromCatalogItems < ActiveRecord::Migration
  def up
    remove_index :catalog_items, :insert_id
    remove_column :catalog_items, :insert_id
  end

  def down
    add_column :catalog_items, :insert_id, :integer
    add_index :catalog_items, :insert_id
  end
end

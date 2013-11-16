class CreateCatalogInsertsItemsTable < ActiveRecord::Migration
  def change
    create_table :catalog_inserts_items do |t|
      t.references :insert, null: false
      t.references :item, null: false
    end
    add_index :catalog_inserts_items, :insert_id
    add_index :catalog_inserts_items, :item_id
  end
end

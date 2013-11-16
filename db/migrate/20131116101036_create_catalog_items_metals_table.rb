class CreateCatalogItemsMetalsTable < ActiveRecord::Migration
  def change
    create_table :catalog_items_metals do |t|
      t.references :metal, null: false
      t.references :item, null: false
    end
    add_index :catalog_items_metals, :metal_id
    add_index :catalog_items_metals, :item_id
  end
end

class CreateCatalogItems < ActiveRecord::Migration
  def change
    create_table :catalog_items do |t|
      t.string :article, null: false
      t.decimal :weight, null: false
      t.string :metal, null: false
      t.string :image
      t.references :category, null: false
      t.references :insert

      t.timestamps
    end
    add_index :catalog_items, :metal
    add_index :catalog_items, :article
    add_index :catalog_items, :category_id
    add_index :catalog_items, :insert_id
  end
end

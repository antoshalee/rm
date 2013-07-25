class CreateCollectionItems < ActiveRecord::Migration
  def change
    create_table :collection_items do |t|
      t.string :article
      t.decimal :weight
      t.string :image
      t.references :collection
      t.timestamps
    end
    add_index :collection_items, :collection_id
  end
end

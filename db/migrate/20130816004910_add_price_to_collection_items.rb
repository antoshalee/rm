class AddPriceToCollectionItems < ActiveRecord::Migration
  def change
    add_column :collection_items, :price, :decimal, precision: 8, scale: 2
  end
end

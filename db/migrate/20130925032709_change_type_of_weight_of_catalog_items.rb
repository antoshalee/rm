class ChangeTypeOfWeightOfCatalogItems < ActiveRecord::Migration
  def up
    remove_column :catalog_items, :weight
    add_column :catalog_items, :weight, :string
  end

  def down
    remove_column :catalog_items, :weight
    add_column :catalog_items, :decimal
  end
end

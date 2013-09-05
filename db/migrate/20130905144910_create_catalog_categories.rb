class CreateCatalogCategories < ActiveRecord::Migration
  def change
    create_table :catalog_categories do |t|
      t.string :name, null: false
      t.integer :position
      t.timestamps
    end
  end
end

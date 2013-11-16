class CreateCatalogMetals < ActiveRecord::Migration
  def change
    create_table :catalog_metals do |t|
      t.string :name
      t.integer :position
      t.timestamps
    end
  end
end

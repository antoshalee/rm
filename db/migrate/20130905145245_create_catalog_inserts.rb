class CreateCatalogInserts < ActiveRecord::Migration
  def change
    create_table :catalog_inserts do |t|
      t.string :name, null: false
      t.integer :position
      t.timestamps
    end
  end
end

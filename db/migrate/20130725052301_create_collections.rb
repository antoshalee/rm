class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :title
      t.string :price
      t.text :description
      t.integer :position
      t.string :note

      t.timestamps
    end
  end
end

class CreateMagazines < ActiveRecord::Migration
  def change
    create_table :magazines do |t|
      t.string :url
      t.string :embedId
      t.string :documentId
      t.text :lead
      t.string :title
      t.integer :position
      t.timestamps
    end
  end
end

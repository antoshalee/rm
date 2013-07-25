class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :title
      t.string :image
      t.text :description
      t.integer :position
      t.timestamps
    end
  end
end

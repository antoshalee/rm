class CreateWholesaleManagers < ActiveRecord::Migration
  def change
    create_table :wholesale_managers do |t|
      t.string :name
      t.text :description
      t.string :image
      t.integer :position

      t.timestamps
    end
  end
end

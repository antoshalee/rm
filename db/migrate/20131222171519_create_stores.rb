class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.float :lat
      t.float :lng
      t.string :address
      t.string :phone
      t.string :opening_hours
      t.string :image
      t.string :email
      t.string :description
      t.integer :position

      t.timestamps
    end
  end
end

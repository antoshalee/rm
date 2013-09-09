class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.string :title
      t.string :image
      t.string :color
      t.integer :position
      t.timestamps
    end
  end
end

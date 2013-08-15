class CreateMagazines < ActiveRecord::Migration
  def change
    create_table :magazines do |t|
      t.string :code
      t.text :lead
      t.string :title
      t.integer :position

      t.timestamps
    end
  end
end

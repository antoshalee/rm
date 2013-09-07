class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :number
      t.integer :discount

      t.timestamps
    end
    add_index :cards, :number
  end
end

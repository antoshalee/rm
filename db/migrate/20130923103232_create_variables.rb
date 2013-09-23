class CreateVariables < ActiveRecord::Migration
  def change
    create_table :variables do |t|
      t.string :key
      t.string :label
      t.text :value

      t.timestamps
    end
    add_index :variables, :key
  end
end

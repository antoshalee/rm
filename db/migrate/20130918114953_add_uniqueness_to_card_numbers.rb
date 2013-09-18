class AddUniquenessToCardNumbers < ActiveRecord::Migration
  def up
    remove_index :cards, :number
    add_index :cards, :number, unique: true
  end

  def down
    remove_index :cards, :number
    add_index :cards, :number
  end
end

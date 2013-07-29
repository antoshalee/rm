class AddIsMainToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :is_main, :boolean, default: false
    add_index :offers, :is_main
  end
end

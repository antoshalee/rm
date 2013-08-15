class AddDiscountToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :discount, :boolean, default: false
  end
end

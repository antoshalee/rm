class AddPositionToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :position, :integer
  end
end

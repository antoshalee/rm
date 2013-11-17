class AddSidebarIdToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :sidebar_id, :integer
  end
end

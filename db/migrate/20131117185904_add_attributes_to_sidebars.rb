class AddAttributesToSidebars < ActiveRecord::Migration
  def change
    add_column :sidebars, :display_on_articles_page, :boolean, default: false
    add_column :sidebars, :display_on_offers_page, :boolean, default: false
  end
end

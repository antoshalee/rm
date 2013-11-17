class AddSidebarIdToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :sidebar_id, :integer
  end
end

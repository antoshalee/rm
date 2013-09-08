class RemoveLeadFromArticles < ActiveRecord::Migration
  def up
    remove_column :articles, :lead
  end

  def down
    add_column :articles, :lead, :text
  end
end

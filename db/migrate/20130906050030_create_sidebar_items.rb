class CreateSidebarItems < ActiveRecord::Migration
  def change
    create_table :sidebar_items do |t|
      t.string :title
      t.text :text
      t.references :page
      t.integer :position
      t.timestamps
    end
    add_index :sidebar_items, :page_id
  end
end

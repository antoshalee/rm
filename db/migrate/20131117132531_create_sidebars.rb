class CreateSidebars < ActiveRecord::Migration
  def change
    create_table :sidebars do |t|
      t.string :kind
      t.timestamps
    end
  end
end

class CreateActions < ActiveRecord::Migration
  def self.up
    create_table :actions do |t|
      t.string :title
      t.date :date_start
      t.date :date_finish
      t.text :lead
      t.text :content
      t.string :image
      t.timestamps
    end
  end

  def self.down
    drop_table :actions
  end
end

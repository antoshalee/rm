class CreateContactGroups < ActiveRecord::Migration
  def change
    create_table :contact_groups do |t|
      t.string :name, null: false
      t.integer :position, null: false

      t.timestamps
    end
  end
end

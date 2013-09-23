class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :contact_group, null: false
      t.text :content, null: false

      t.timestamps
    end
    add_index :contacts, :contact_group_id
  end
end

class CreateAlbumItems < ActiveRecord::Migration
  def change
    create_table :album_items do |t|
      t.string :image
      t.references :album

      t.timestamps
    end
    add_index :album_items, :album_id
  end
end

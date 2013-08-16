class AddDescriptionToAlbumItems < ActiveRecord::Migration
  def change
    add_column :album_items, :description, :text
  end
end

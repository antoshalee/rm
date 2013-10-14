class AddPublishedAtToAlbums < ActiveRecord::Migration
  def up
    add_column :albums, :published_at, :date
    Album.all.each do |album|
      album.published_at = album.created_at.to_date
      album.save!
    end
  end

  def down
    remove_column :albums, :published_at
  end
end

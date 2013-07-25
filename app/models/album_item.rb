class AlbumItem < ActiveRecord::Base
  attr_accessible :image
  belongs_to :album
  mount_uploader :image, AlbumItemImageUploader
end

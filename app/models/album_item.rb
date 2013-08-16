class AlbumItem < ActiveRecord::Base
  attr_accessible :image, :description
  belongs_to :album
  mount_uploader :image, AlbumItemImageUploader
end

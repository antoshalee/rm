class AlbumItem < ActiveRecord::Base
  attr_accessible :image, :description, :album
  belongs_to :album
  mount_uploader :image, AlbumItemImageUploader

  def self.random
    order "RANDOM()"
  end
end

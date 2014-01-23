class CollectionItem < ActiveRecord::Base
  attr_accessible :article, :collection, :image, :weight, :price
  belongs_to :collection
  mount_uploader :image, CollectionItemImageUploader
end

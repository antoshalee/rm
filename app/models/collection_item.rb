class CollectionItem < ActiveRecord::Base
  attr_accessible :article, :image, :weight
  belongs_to :collection
  mount_uploader :image, CollectionItemImageUploader
end

class Catalog::Item < ActiveRecord::Base
  METALS = %w(gold silver)
  belongs_to :category
  belongs_to :insert
  attr_accessible :article, :metal, :weight, :insert_id, :category_id, :image
  validates :metal, presence: true, inclusion: METALS
  validates :article, presence: true
  validates :category, presence: true
  validates :image, presence: true

  mount_uploader :image, CatalogItemImageUploader
end

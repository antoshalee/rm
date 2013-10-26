class Catalog::Item < ActiveRecord::Base
  METALS = %w(gold silver)
  belongs_to :category
  belongs_to :insert
  attr_accessible :article, :metal, :weight, :insert_id, :category_id, :image, :remove_image
  validates :metal, presence: true, inclusion: METALS
  validates :article, presence: true
  validates :category, presence: true
  validates :image, presence: true

  mount_uploader :image, CatalogItemImageUploader

  def self.by_insert insert
    where(insert_id: insert)
  end

  def self.by_category category
    where(category_id: category)
  end

  def self.by_metal metal
    where(metal: metal)
  end

  def self.by_article article
  	where(article: article)
  end
end

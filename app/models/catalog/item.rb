class Catalog::Item < ActiveRecord::Base
  METALS = %w(gold silver)
  belongs_to :category
  has_and_belongs_to_many :inserts, join_table: "catalog_inserts_items"
  has_and_belongs_to_many :metals, join_table: "catalog_items_metals"
  attr_accessible :article, :metal, :weight, :metal_ids, :insert_ids, :category_id, :image, :remove_image
  validates :metal, presence: true, inclusion: METALS
  validates :article, presence: true
  validates :category, presence: true
  validates :image, presence: true

  mount_uploader :image, CatalogItemImageUploader

  def self.by_insert insert
    joins(:inserts).where(catalog_inserts_items: {insert_id: insert})
  end

  def self.by_category category
    where(category_id: category)
  end

  def self.by_metal metal
    joins(:metals).where(catalog_items_metals: {metal_id: metal})
  end

  def self.by_article article
  	where(article: article)
  end
end

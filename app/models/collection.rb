class Collection < ActiveRecord::Base
  acts_as_list
  attr_accessible :description, :note, :position, :price, :title, :collection_items_attributes, :tag_list
  has_many :collection_items, order: :id, inverse_of: :collection
  accepts_nested_attributes_for :collection_items, allow_destroy: true
  acts_as_taggable
end

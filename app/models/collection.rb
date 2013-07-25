class Collection < ActiveRecord::Base
  attr_accessible :description, :note, :position, :price, :title, :collection_items_attributes
  has_many :collection_items, order: :id, inverse_of: :collection
  accepts_nested_attributes_for :collection_items, allow_destroy: true
end

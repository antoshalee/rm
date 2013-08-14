class Album < ActiveRecord::Base
  attr_accessible :content, :title, :album_items_attributes, :tag_list
  has_many :album_items, order: :id, inverse_of: :album
  accepts_nested_attributes_for :album_items, allow_destroy: true
  acts_as_taggable
end

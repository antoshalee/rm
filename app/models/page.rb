class Page < ActiveRecord::Base
  attr_accessible :content, :title, :url, :sidebar_items_attributes
  has_many :sidebar_items, dependent: :destroy, order: :position
  accepts_nested_attributes_for :sidebar_items, allow_destroy: true
  validates :title, presence: true
  validates :url, presence: true
end

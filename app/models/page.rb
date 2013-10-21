class Page < ActiveRecord::Base
  extend Enumerize
  attr_accessible :content, :title, :url, :sidebar_items_attributes, :template
  has_many :sidebar_items, dependent: :destroy, order: :position
  accepts_nested_attributes_for :sidebar_items, allow_destroy: true
  validates :title, presence: true
  validates :url, presence: true
  validates :template, presence: true

  enumerize :template, in: [:standard, :discount],
    default: :standard,
    predicates: true
end

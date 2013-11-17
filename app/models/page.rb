class Page < ActiveRecord::Base
  extend Enumerize
  attr_accessible :content, :title, :url, :sidebar_items_attributes, :template, :sidebar_id
  has_many :sidebar_items, dependent: :destroy, order: :position
  belongs_to :sidebar
  validates :title, presence: true
  validates :url, presence: true
  validates :template, presence: true

  enumerize :template, in: [:standard, :discount],
    default: :standard,
    predicates: true
end

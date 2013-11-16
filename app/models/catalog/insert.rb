class Catalog::Insert < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :items, join_table: "catalog_inserts_items"
  acts_as_list
  validates :name, presence: true
end

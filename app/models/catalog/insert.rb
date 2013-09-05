class Catalog::Insert < ActiveRecord::Base
  attr_accessible :name
  has_many :items, dependent: :restrict
  acts_as_list
  validates :name, presence: true
end

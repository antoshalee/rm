class Catalog::Metal < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true
  acts_as_list
end

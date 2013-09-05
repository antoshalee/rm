class Catalog::Category < ActiveRecord::Base
  attr_accessible :name
  acts_as_list
  validates :name, presence: true
end

class WholesaleManager < ActiveRecord::Base
  attr_accessible :description, :image, :name, :position
  acts_as_list
  mount_uploader :image, WholesaleManagerImageUploader
  validates_presence_of :name, :description
end

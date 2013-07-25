class Supplier < ActiveRecord::Base
  acts_as_list
  attr_accessible :description, :image, :position, :title
  mount_uploader :image, SupplierImageUploader
  validates_presence_of :title, :description, :image
end

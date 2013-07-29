class Banner < ActiveRecord::Base
  acts_as_list
  attr_accessible :image, :position, :text
  mount_uploader :image, BannerImageUploader
end

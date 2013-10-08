class Banner < ActiveRecord::Base
  acts_as_list
  attr_accessible :image, :position, :text, :url
  mount_uploader :image, BannerImageUploader
end

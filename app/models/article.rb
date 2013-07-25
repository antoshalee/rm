class Article < ActiveRecord::Base
  attr_accessible :content, :image, :lead, :title

  mount_uploader :image, ArticleImageUploader
end

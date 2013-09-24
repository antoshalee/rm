class Article < ActiveRecord::Base
  attr_accessible :content, :image, :title, :published_at
  validates_presence_of :content, :title, :published_at
  mount_uploader :image, ArticleImageUploader
  after_initialize :init

  private

  def init
    if self.new_record? && self.published_at.nil?
      self.published_at = Time.now.to_date
    end
  end

end

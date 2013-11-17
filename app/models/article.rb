class Article < ActiveRecord::Base
  attr_accessible :content, :image, :title, :published_at, :remove_image, :sidebar_id
  validates_presence_of :content, :title, :published_at
  mount_uploader :image, ArticleImageUploader
  after_initialize :init
  belongs_to :sidebar

  private

  def init
    if self.new_record? && self.published_at.nil?
      self.published_at = Time.now.to_date
    end
  end

end

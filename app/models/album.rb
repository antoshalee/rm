class Album < ActiveRecord::Base
  attr_accessible :content, :title, :album_items_attributes, :tag_list, :published_at
  has_many :album_items, order: :id, inverse_of: :album, dependent: :destroy
  accepts_nested_attributes_for :album_items, allow_destroy: true
  acts_as_taggable
  after_initialize :init

  private

  def init
    if self.new_record? && self.published_at.nil?
      self.published_at = Time.now.to_date
    end
  end
end

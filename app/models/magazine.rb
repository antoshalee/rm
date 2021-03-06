# encoding: utf-8
class Magazine < ActiveRecord::Base
  acts_as_list
  attr_accessible :url, :lead, :position, :title

  before_validation :sanitize_url
  before_validation :grub_codes_from_remote_page

  def link_to_cover_img
    "http://image.issuu.com/#{self.documentId}/jpg/page_1_thumb_large.jpg"
  end

  private

  def grub_codes_from_remote_page
    if self.url_changed?
      require 'open-uri'
      open self.url do |page|
        content = page.read()
        self.documentId = content.scan(/\"documentId\":\"(.+?)\"/)[0][0]
        self.embedId = content.scan(/\"embedId\":\"(.+?)\"/)[0][0]
      end
    end
  rescue
    self.errors.add(:url, "Не получилось получить системные данные по этому адресу")
  end

  def sanitize_url
    self.url = "http://#{self.url}" unless self.url.match /^http/
  end
end

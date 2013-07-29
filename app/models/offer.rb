class Offer < ActiveRecord::Base
  attr_accessible :date_start, :date_finish, :lead, :content, :title, :image, :is_main, :tag_list
  mount_uploader :image, OfferImageUploader
  acts_as_taggable

  after_initialize :set_default_values
  after_commit :on_after_commit_handler

  def self.main
    where(is_main: true)
  end

  # not main
  def self.common
    where(is_main: false)
  end

private

  def set_default_values
    if new_record?
      self.date_start   ||= Date.today
      self.date_finish  ||= Date.today
    end
  end

  def on_after_commit_handler
    if is_main_changed? || is_main==true
      # unset 'is_main' attr for other articles
      Offer.main.where('id <> ?', self.id).each {|a| a.is_main = false; a.save}
      nil
    end
  end

end

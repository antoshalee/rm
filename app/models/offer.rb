class Offer < ActiveRecord::Base
  attr_accessible :date_start, :date_finish, :lead, :content, :title, :image
  mount_uploader :image, OfferImageUploader

  after_initialize :set_default_values

  def set_default_values
    if new_record?
      self.date_start   ||= Date.today
      self.date_finish  ||= Date.today
    end
  end
end

# -*- encoding : utf-8 -*-
class Sidebar < ActiveRecord::Base
  extend Enumerize
  attr_accessible :kind, :sidebar_items_attributes, :display_on_articles_page, :display_on_offers_page
  has_many :sidebar_items, dependent: :destroy, order: :position
  accepts_nested_attributes_for :sidebar_items, allow_destroy: true
  validates :kind, presence: true, uniqueness: {if: ->(s) { !s.kind.try(:customized?) }}

  enumerize :kind, in: %w(
    customized
    discount_offers
  )

  def title
    kind.text + if kind.customized?
      " #{sidebar_items.try(:first).try(:text)}"[0..20]
    end.to_s
  end
end

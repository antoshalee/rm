class Letter < ActiveRecord::Base
  COLORS = %w(black brown gray bistre white)
  attr_accessible :image, :title, :color
  mount_uploader :image, LetterImageUploader
  acts_as_list
  validates :title, presence: true
  validates :image, presence: true
  validates :color, presence: true, inclusion: COLORS
end

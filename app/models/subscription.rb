class Subscription < ActiveRecord::Base
  attr_accessible :address, :email, :kind, :name, :phone
  validates :name, presence: true
  validates :email, presence: true
  validates :kind, inclusion: %w(digital paper), presence: true
end

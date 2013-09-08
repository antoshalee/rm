class Subscription < ActiveRecord::Base
  attr_accessible :address, :email, :kind, :name, :phone
  validates :name, presence: true
  validates :email, presence: true
  validates :kind, inclusion: %w(digital paper), presence: true

  before_create :generate_confirmation_token

  def self.confirmed
    where("confirmed_at is not null")
  end

  def confirmed?
    confirmed_at.present?
  end

  private

  def generate_confirmation_token
    require 'digest/sha1'
    self.confirmation_token = Digest::SHA1.hexdigest "#{self.email}#{Time.now}salty remixed phrase"
  end
end

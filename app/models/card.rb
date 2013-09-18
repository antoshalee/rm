class Card < ActiveRecord::Base
  attr_accessible :discount, :number, :balance

  def to_s
    number
  end
end

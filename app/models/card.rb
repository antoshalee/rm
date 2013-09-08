class Card < ActiveRecord::Base
  attr_accessible :discount, :number

  def to_s
    number
  end
end

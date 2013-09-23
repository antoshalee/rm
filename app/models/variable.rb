class Variable < ActiveRecord::Base
  attr_accessible :key, :label, :value
  validates_presence_of :key, :label, :value

  def to_param
    key
  end
end

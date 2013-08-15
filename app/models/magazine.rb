class Magazine < ActiveRecord::Base
  attr_accessible :code, :lead, :position, :title
  acts_as_list
end

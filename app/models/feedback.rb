class Feedback < ActiveRecord::Base
  attr_accessible :email, :name, :text
end

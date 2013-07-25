class Action < ActiveRecord::Base
  attr_accessible :date_start, :date_finish, :lead, :content
end

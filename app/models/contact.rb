class Contact < ActiveRecord::Base
  belongs_to :contact_group
  attr_accessible :content
end

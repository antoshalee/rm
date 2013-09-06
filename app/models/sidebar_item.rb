class SidebarItem < ActiveRecord::Base
  attr_accessible :text, :title
  belongs_to :page
  acts_as_list scope: :page
end

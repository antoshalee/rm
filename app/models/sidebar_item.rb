class SidebarItem < ActiveRecord::Base
  attr_accessible :text, :title
  belongs_to :sidebar
  acts_as_list scope: :sidebar
end

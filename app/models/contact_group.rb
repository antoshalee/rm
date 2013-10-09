class ContactGroup < ActiveRecord::Base
  acts_as_list
  attr_accessible :name, :position, :contacts_attributes, :address
  has_many :contacts, order: :id, inverse_of: :contact_group
  accepts_nested_attributes_for :contacts, allow_destroy: true
end

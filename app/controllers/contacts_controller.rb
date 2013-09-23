class ContactsController < ApplicationController
  def index
    @contact_groups = ContactGroup.order("position asc")
  end
end

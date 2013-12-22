class Store < ActiveRecord::Base
  acts_as_list
  attr_accessible :address, :description, :email, :image, :lat, :lng, :name, :opening_hours, :phone, :position
end

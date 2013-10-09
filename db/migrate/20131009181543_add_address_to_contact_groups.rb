class AddAddressToContactGroups < ActiveRecord::Migration
  def change
    add_column :contact_groups, :address, :string
  end
end

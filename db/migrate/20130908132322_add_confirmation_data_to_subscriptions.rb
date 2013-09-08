class AddConfirmationDataToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :confirmation_token, :string
    add_column :subscriptions, :confirmed_at, :datetime
    add_index :subscriptions, :confirmation_token
    add_index :subscriptions, :confirmed_at
  end
end

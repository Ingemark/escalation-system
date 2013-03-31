class AddAddressIdIndexToSubscriptions < ActiveRecord::Migration
  def change
    add_index :subscriptions, :delivery_address_id
  end
end

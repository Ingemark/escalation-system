class AddConsumerIdIndexToDeliveryAddresses < ActiveRecord::Migration
  def change
    add_index :delivery_addresses, :consumer_id
  end
end

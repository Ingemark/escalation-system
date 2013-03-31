class AddDeliveryServiceIdIndexToDeliveryAddresses < ActiveRecord::Migration
  def change
    add_index :delivery_addresses, :delivery_service_id
  end
end

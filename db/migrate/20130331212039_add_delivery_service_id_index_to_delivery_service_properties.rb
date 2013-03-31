class AddDeliveryServiceIdIndexToDeliveryServiceProperties < ActiveRecord::Migration
  def change
    add_index :delivery_service_properties, :delivery_service_id
  end
end

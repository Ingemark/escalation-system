class CreateDeliveryServiceProperties < ActiveRecord::Migration
  def change
    create_table :delivery_service_properties do |t|
      t.string :key
      t.string :value
      t.integer :delivery_service_id

      t.timestamps
    end
  end
end

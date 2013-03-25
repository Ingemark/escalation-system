class CreateDeliveryAddresses < ActiveRecord::Migration
  def change
    create_table :delivery_addresses do |t|
      t.string :name
      t.string :address
      t.integer :delivery_service_id
      t.integer :consumer_id

      t.timestamps
    end
  end
end

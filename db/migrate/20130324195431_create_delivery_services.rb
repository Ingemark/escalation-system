class CreateDeliveryServices < ActiveRecord::Migration
  def change
    create_table :delivery_services do |t|
      t.string :name

      t.timestamps
    end
  end
end

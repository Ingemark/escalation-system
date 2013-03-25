class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.integer :escalation_level_id
      t.integer :delivery_address_id
      t.integer :consumer_sequence

      t.timestamps
    end
  end
end

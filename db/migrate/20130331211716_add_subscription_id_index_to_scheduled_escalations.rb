class AddSubscriptionIdIndexToScheduledEscalations < ActiveRecord::Migration
  def change
    add_index :scheduled_escalations, :subscription_id
  end
end

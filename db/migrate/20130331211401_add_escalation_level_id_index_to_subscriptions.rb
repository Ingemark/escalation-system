class AddEscalationLevelIdIndexToSubscriptions < ActiveRecord::Migration
  def change
    add_index :subscriptions, :escalation_level_id
  end
end

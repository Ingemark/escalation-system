class AddContextIdIndexToEscalationLevels < ActiveRecord::Migration
  def change
    add_index :escalation_levels, :context_id
  end
end

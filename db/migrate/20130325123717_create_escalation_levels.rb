class CreateEscalationLevels < ActiveRecord::Migration
  def change
    create_table :escalation_levels do |t|
      t.string :name
      t.integer :context_id
      t.integer :level
      t.integer :when
      t.boolean :sequential_notification

      t.timestamps
    end
  end
end

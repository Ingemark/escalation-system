class CreateScheduledEscalations < ActiveRecord::Migration
  def change
    create_table :scheduled_escalations do |t|
      t.integer :subscription_id
      t.datetime :duedate
      t.string :external_reference_id
      t.string :status

      t.timestamps
    end
  end
end

class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.integer :context_id
      t.integer :delivery_service_id
      t.string :field
      t.string :body

      t.timestamps
    end
  end
end

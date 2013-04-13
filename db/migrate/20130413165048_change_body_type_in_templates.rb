class ChangeBodyTypeInTemplates < ActiveRecord::Migration
  def up
    change_column :templates, :body, :text
  end

  def down
    change_column :templates, :body, :string
  end
end

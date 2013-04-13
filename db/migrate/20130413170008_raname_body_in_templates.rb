class RanameBodyInTemplates < ActiveRecord::Migration
  def up
    rename_column :templates, :body, :content
  end

  def down
    rename_column :templates, :content, :body
  end
end

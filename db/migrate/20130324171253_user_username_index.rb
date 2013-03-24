class UserUsernameIndex < ActiveRecord::Migration
  def up
    add_index "users", ["username"], :name => 'index_users_on_username',
      :unique => true
  end

  def down
  end
end

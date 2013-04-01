class UserRole < ActiveRecord::Base
  set_table_name "users_roles"

  attr_accessible :user_id, :role_id

  validates :user_id, :role_id, presence: :true
  validates :user_id, uniqueness: {:scope => :role_id}
  
  belongs_to :user
  belongs_to :role

  rails_admin do
    navigation_label 'User'
  end

end

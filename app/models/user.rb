class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation,
    :remember_me
  # attr_accessible :title, :body
  #

  rails_admin do
    list do
      field :id
      field :username
      field :email
    end
    show do
      field :username
      field :email
      field :sign_in_count
      field :current_sign_in_at
      field :last_sign_in_at
      field :current_sign_in_ip
      field :last_sign_in_ip
    end
    edit do
      field :username
      field :email
      field :password
      field :password_confirmation
    end
  end
end

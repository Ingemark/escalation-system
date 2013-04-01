class User < ActiveRecord::Base
  rolify
  devise :database_authenticatable, :rememberable, :trackable, :validatable,
    :token_authenticatable

  attr_accessible :username, :email, :password, :password_confirmation,
    :remember_me

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :password_confirmation, presence: true

  rails_admin do
    navigation_label 'User'

    object_label_method do
      :custom_name_method
    end

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

  def custom_name_method
    self.username
  end
end

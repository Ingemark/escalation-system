class Consumer < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :delivery_addresses, dependent: :destroy

  rails_admin do
    navigation_label 'Delivery'
  end
end

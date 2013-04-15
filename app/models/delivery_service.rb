class DeliveryService < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :delivery_service_properties, dependent: :destroy
  has_many :delivery_addresses, dependent: :destroy
  has_many :templates, dependent: :destroy

  rails_admin do
    navigation_label 'Delivery'
  end
end

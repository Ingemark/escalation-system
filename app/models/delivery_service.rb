class DeliveryService < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :delivery_service_properties, dependent: :destroy
  has_many :delivery_addresses, dependent: :destroy
end

class DeliveryServiceProperty < ActiveRecord::Base
  attr_accessible :delivery_service_id, :key, :value

  validates :key, :value, :delivery_service_id, presence: true
  validates :key, uniqueness: true

  belongs_to :delivery_service
end

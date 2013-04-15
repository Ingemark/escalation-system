class DeliveryServiceProperty < ActiveRecord::Base
  attr_accessible :delivery_service_id, :key, :value

  validates :key, :value, :delivery_service_id, presence: true
  validates :key, uniqueness: { :scope => :delivery_service_id }

  belongs_to :delivery_service

  rails_admin do
    navigation_label 'Delivery'
  end
end

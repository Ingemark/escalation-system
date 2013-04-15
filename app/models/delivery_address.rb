class DeliveryAddress < ActiveRecord::Base
  attr_accessible :address, :consumer_id, :delivery_service_id, :name

  validates :name, :address, :delivery_service_id, :consumer_id,
    presence: true

  belongs_to :delivery_service
  belongs_to :consumer

  has_many :subscriptions

  rails_admin do
    navigation_label 'Delivery'
  end
end

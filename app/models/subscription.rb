class Subscription < ActiveRecord::Base
  attr_accessible :consumer_sequence, :delivery_address_id,
    :escalation_level_id, :name

  validates :consumer_sequence, :delivery_address_id, :escalation_level_id,
    :name, presence: true
  validates :consumer_sequence, numericality: {greater_than_or_equal_to: 1}

  belongs_to :escalation_level
  belongs_to :delivery_address
end

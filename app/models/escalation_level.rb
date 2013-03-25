class EscalationLevel < ActiveRecord::Base
  attr_accessible :context_id, :level, :name, :sequential_notification, :when

  validates :name, :context_id, :level, :when, presence: true
  validates :level, :when, numericality: {greater_than_or_equal_to: 1}
  validates :level, uniqueness: {:scope => :context_id}

  belongs_to :context
end

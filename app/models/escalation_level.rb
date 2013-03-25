class EscalationLevel < ActiveRecord::Base
  attr_accessible :context_id, :level, :name, :sequential_notification, :when

  validates :name, :context_id, :level, :when

  belongs_to :context
end

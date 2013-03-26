class ScheduledEscalation < ActiveRecord::Base
  attr_accessible :duedate, :external_reference_id, :status, :subscription_id

  validates  :duedate, :external_reference_id, :status, :subscription_id,
    presence: true

  belongs_to :subscription
end

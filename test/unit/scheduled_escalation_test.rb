require 'test_helper'

class ScheduledEscalationTest < ActiveSupport::TestCase
  test "attributes must not be empty" do
    scheduled_escalation = ScheduledEscalation.new
    assert scheduled_escalation.invalid?
    assert scheduled_escalation.errors[:duedate].any?
    assert scheduled_escalation.errors[:external_reference_id].any?
    assert scheduled_escalation.errors[:status].any?
    assert scheduled_escalation.errors[:subscription_id].any?
  end
end

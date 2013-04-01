require 'test_helper'

class EscalationLevelTest < ActiveSupport::TestCase
  test "attributes must not be empty" do
    escalation_level = EscalationLevel.new
    assert escalation_level.invalid?
    assert escalation_level.errors[:name].any?
    assert escalation_level.errors[:context_id].any?
    assert escalation_level.errors[:level].any?
    assert escalation_level.errors[:when].any?
  end

  test "context & level must be unique" do
    context = Context.create(name: "test context")
    escalation_level1 = EscalationLevel.create(name: "test",
                                              context_id: context.id,
                                              level: 1,
                                              when: 50,
                                              sequential_notification: true)
    assert escalation_level1.valid?

    escalation_level2 = EscalationLevel.create(name: "test",
                                              context_id: context.id,
                                              level: 1,
                                              when: 50,
                                              sequential_notification: true)
    assert escalation_level2.invalid?
    assert escalation_level2.errors[:level].any?
  end

  test "level and when must be greater than 0" do
    escalation_level = EscalationLevel.new(name: "test",
                                           context_id: 1,
                                           level: 0,
                                           when: "a",
                                           sequential_notification: true)
    assert escalation_level.invalid?
    assert escalation_level.errors[:level].any?
    assert escalation_level.errors[:when].any?
  end
end

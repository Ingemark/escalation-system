require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  test "attributes must not be empty" do
    subscription = Subscription.new
    assert subscription.invalid?
    assert subscription.errors[:name].any?
    assert subscription.errors[:escalation_level_id].any?
    assert subscription.errors[:delivery_address_id].any?
    assert subscription.errors[:consumer_sequence].any?
  end

  test "consumer_sequence must be greater than 0" do
    subscription = Subscription.new(name: "test",
                                        escalation_level_id: 1,
                                        delivery_address_id: 0,
                                        consumer_sequence: -1)
    assert subscription.invalid?
    assert subscription.errors[:consumer_sequence].any?
  end

  test "escalation_level and consumer_sequence must be unique" do
    subscription1 = Subscription.create(name: "test",
                                        escalation_level_id: 1,
                                        delivery_address_id: 1,
                                        consumer_sequence: 1)
    assert subscription1.valid?
    
    subscription2 = Subscription.create(name: "test",
                                        escalation_level_id: 1,
                                        delivery_address_id: 1,
                                        consumer_sequence: 1)
    assert subscription2.invalid?
    assert subscription2.errors[:consumer_sequence].any?
  end
end

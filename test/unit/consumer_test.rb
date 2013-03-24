require 'test_helper'

class ConsumerTest < ActiveSupport::TestCase
  test "attributes must not be empty" do
    consumer = Consumer.new
    assert consumer.invalid?
    assert consumer.errors[:name].any?
  end

  test "name must be unique" do
    consumer1 = Consumer.create(name: "hrvoje")
    assert consumer1.valid?

    consumer2 = Consumer.new(name: "hrvoje")
    assert consumer2.invalid?
  end
end

require 'test_helper'

class DeliveryAddressTest < ActiveSupport::TestCase
  test "attributes must not be empty" do
    delivery_address = DeliveryAddress.new
    assert delivery_address .invalid?
    assert delivery_address.errors[:name].any?
    assert delivery_address.errors[:address].any?
    assert delivery_address.errors[:delivery_service_id].any?
    assert delivery_address.errors[:consumer_id].any?
  end
end

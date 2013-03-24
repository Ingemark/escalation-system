require 'test_helper'

class DeliveryServiceTest < ActiveSupport::TestCase
  test "attributes must not be empty" do
    delivery_service = DeliveryService.new
    assert delivery_service.invalid?
    assert delivery_service.errors[:name].any?
  end

  test "name must be unique" do
    delivery_service1 = DeliveryService.create(name: "mail")
    assert delivery_service1.valid?

    delivery_service2 = DeliveryService.new(name: "mail")
    assert delivery_service2.invalid?
  end
end

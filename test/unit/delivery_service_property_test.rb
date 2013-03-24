require 'test_helper'

class DeliveryServicePropertyTest < ActiveSupport::TestCase
  test "attributes must not be empty" do
    delivery_service_property = DeliveryServiceProperty.new
    assert delivery_service_property.invalid?
    assert delivery_service_property.errors[:key].any?
    assert delivery_service_property.errors[:value].any?
    assert delivery_service_property.errors[:delivery_service_id].any?
  end

  test "key must be unique" do
    delivery_service = DeliveryService.create(name: "phone")
    delivery_service_property1 = DeliveryServiceProperty.create(
                                   key: "smtp",
                                   value: "smtp.com",
                                   delivery_service_id: delivery_service.id)
    assert delivery_service_property1.valid?

    delivery_service_property2 = DeliveryServiceProperty.create(
                                   key: "smtp",
                                   value: "smtp.com",
                                   delivery_service_id: delivery_service.id)
    assert delivery_service_property2.invalid?
  end
end

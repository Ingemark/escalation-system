require 'test_helper'

class TemplateTest < ActiveSupport::TestCase
  test "attributes must not be empty" do
    template = Template.new
    assert template.invalid?
    assert template.errors[:context_id].any?
    assert template.errors[:delivery_service_id].any?
    assert template.errors[:field].any?
    assert template.errors[:content].any?
  end

  test "field, context & delivery_service must be unique" do
    template1 = Template.create(context_id: contexts(:inge_mark).id,
                                delivery_service_id: delivery_services(:mail).id,
                                field: 'test',
                                content: 'test',)
    assert template1.valid?

    template2 = Template.new(context_id: contexts(:inge_mark).id,
                                delivery_service_id: delivery_services(:mail).id,
                                field: 'test',
                                content: 'test',)
    assert template2.invalid?
    assert template2.errors[:field].any?
  end
end

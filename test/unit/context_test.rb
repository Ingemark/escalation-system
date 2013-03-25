require 'test_helper'

class ContextTest < ActiveSupport::TestCase
  test "attributes must not be empty" do
    context = Context.new
    assert context.invalid?
    assert context.errors[:name].any?
  end

  test "name must be unique" do
    context1 = Context.create(name: "system admin")
    assert context1.valid?

    context2 = Context.new(name: "system admin")
    assert context2.invalid?
  end
end

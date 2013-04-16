require 'test_helper'

class EscalationMailerTest < ActionMailer::TestCase
  test 'escalation_mail' do
    escal = scheduled_escalations(:one)

    email = EscalationMailer.escalate(escal).deliver
    assert !ActionMailer::Base.deliveries.empty?

    assert_equal "Eskalator", email.subject
    assert_equal ["alen@inge-mark.hr"], email.to
    assert_match /Ovo je eskalacija/, email.body.encoded
  end
end

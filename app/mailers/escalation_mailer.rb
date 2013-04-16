class EscalationMailer < ActionMailer::Base
  default from: "escalation.system@inge-mark.hr"

  def escalate(escalation)
    @escalation = escalation

    context = escalation.subscription.escalation_level.context
    mail_service = DeliveryService.find_by_name('mail')

    subject = Template.find_by_context_id_and_delivery_service_id_and_field(
      context.id, mail_service.id, 'subject').try(:content) || 'Subject'
    body = Template.find_by_context_id_and_delivery_service_id_and_field(
      context.id, mail_service.id, 'body').try(:content) || 'body'

    mail to: escalation.subscription.delivery_address.address, subject:
      subject do |format|
      format.text  { render :inline => body }
    end
  end
end

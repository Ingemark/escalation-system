class EscalationMailer < ActionMailer::Base
  default from: "escalation.system@inge-mark.hr"

  def escalate(escalation)
    init_smtp
    @escalation = escalation
    context = escalation.subscription.escalation_level.context
    mail_service = DeliveryService.find_by_name('mail')
    subject = Template.find_by_context_id_and_delivery_service_id_and_field(
      context.id, mail_service.id, 'subject').content
    body = Template.find_by_context_id_and_delivery_service_id_and_field(
      context.id, mail_service.id, 'body').content

    mail to: escalation.subscription.delivery_address.address, subject:
      subject do |format|
      format.text  { render :inline => body }
    end
  end

  private
  def init_smtp
    mail_id = DeliveryService.find_by_name('mail').id
    address = DeliveryServiceProperty.find_by_delivery_service_id_and_key(
      mail_id, "address").value
    user_name = DeliveryServiceProperty.find_by_delivery_service_id_and_key(
      mail_id, "user_name").value
    password = DeliveryServiceProperty.find_by_delivery_service_id_and_key(
      mail_id, "password").value
    port = DeliveryServiceProperty.find_by_delivery_service_id_and_key(
      mail_id, "port").value
    authentication = DeliveryServiceProperty.find_by_delivery_service_id_and_key(
      mail_id, "authentication").value

    ActionMailer::Base.smtp_settings = {
      address: address,
      user_name: user_name,
      password: password,
      port: port,
      authentication: authentication }
  end
end

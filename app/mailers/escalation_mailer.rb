class EscalationMailer < ActionMailer::Base
  default from: "escalation.system@inge-mark.hr"

  def escalate
    init_smtp
    mail to: 'hrvoje.kopinc@gmail.com', subject: "Proba"
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

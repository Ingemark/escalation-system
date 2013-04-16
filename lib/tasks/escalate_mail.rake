namespace :escalate do
  
  desc "Send escalation emails"
  task :mail => :environment do
    unless init_smtp
      puts 'Set SMTP parameters: address, user_name, password, port &' \
        ' authentication.'
      next
    end

    ScheduledEscalation.where("status = ? and duedate < ?", 'scheduled',
      Time.now).each do |escal|
      delivery_service = escal.subscription.delivery_address.delivery_service
      delivery_address = escal.subscription.delivery_address.address
      if delivery_service.name == 'mail'
        begin
          EscalationMailer.escalate(escal).deliver
        rescue TimeoutError, IOError, Net::SMTPUnknownError, Net::SMTPServerBusy,
          Net::SMTPAuthenticationError, Net::SMTPFatalError,
          Net::SMTPSyntaxError => e
          puts e.message
          puts "Email not delivered to: #{delivery_address}"
        else
          escal.status = 'delivered'
          escal.save
          puts "Email delivered to: #{delivery_address}"
        end
      end
    end
  end

  def init_smtp
    mail_id = DeliveryService.find_by_name('mail').id
    begin
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
    rescue
      return false
    else
      ActionMailer::Base.smtp_settings = {
        address: address,
        user_name: user_name,
        password: password,
        port: port,
        authentication: authentication }
    end
  end
end

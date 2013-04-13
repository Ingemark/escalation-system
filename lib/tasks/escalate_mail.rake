namespace :escalate do
  
  desc "Send escalation emails"
  task :mail => :environment do
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
end

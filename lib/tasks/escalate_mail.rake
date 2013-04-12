namespace :escalate do
  
  desc "Send escalation emails"
  task :mail => :environment do
    ScheduledEscalation.where("status = ? and duedate < ?", 'scheduled',
      Time.now).each do |escal|
      delivery_service = escal.subscription.delivery_address.
        delivery_service.name 
      if delivery_service == 'mail'
        #catch exceptions
        EscalationMailer.escalate(escal).deliver
        puts 'ok'
      end
    end
  end
end

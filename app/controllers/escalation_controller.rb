class EscalationController < ApplicationController
  # POST /escalation
  def create
    external_reference_id = params[:escalation][:external_reference_id]
    context_id = params[:escalation][:context_id]

    escal_count = 0
    EscalationLevel.where(context_id: context_id).each do |level|
      Subscription.where(escalation_level_id: level.id).each do |sub|
        duedate = DateTime.now + level.when.minutes
        if ScheduledEscalation.create(subscription_id: sub.id,
                                      duedate: duedate,
                                      external_reference_id: external_reference_id,
                                      status: 'scheduled')
          escal_count += 1
        end
      end
    end

    respond_to do |format|
      format.json { render :json => {'escalations created' => escal_count} }
    end
  end

  # DELETE /escalation
  def destroy
    external_reference_id = params[:escalation][:external_reference_id]
    context_id = params[:escalation][:context_id]
    
    escal_count = 0
    EscalationLevel.where(context_id: context_id).each do |level|
      Subscription.where(escalation_level_id: level.id).each do |sub|
        ScheduledEscalation.where(external_reference_id: external_reference_id).
          where(status: 'scheduled').each do |escal|
          escal_count += 1
          escal.status = 'canceled'
          escal.save
        end
      end
    end

    respond_to do |format|
      format.json { render :json => { 'escalations canceled' => escal_count} }
    end
  end
end

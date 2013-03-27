class EscalationController < ApplicationController
  # POST /escalation
  def create
    external_reference_id = params[:escalation][:external_reference_id]
    context_id = params[:escalation][:context_id]

    EscalationLevel.where(context_id: context_id).each do |level|
      Subscription.where(escalation_level_id: level.id).each do |sub|
        duedate = DateTime.now + level.when.minutes
        ScheduledEscalation.create(subscription_id: sub.id,
                                   duedate: duedate,
                                   external_reference_id: external_reference_id,
                                   status: 'scheduled')
        end
    end

    #respond_to do |format|
    #  if @escalation.save
    #    format.json { render json: @escalation, status: :created,
    #      location: @scheduled_escalation }
    #  else
    #    format.json { render json: @escalation.errors, status:
    #      :unprocessable_entity }
    #  end
    #end
    #
    respond_to do |format|
      format.json { render :json => {:status => :created} }
    end
  end

  def destroy
  end
end

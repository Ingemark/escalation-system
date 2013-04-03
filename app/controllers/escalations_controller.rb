class EscalationsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  # POST /escalations
  def create
    external_id = params[:external_reference_id]
    context_id = params[:context_id]

    if external_id.nil? or context_id.nil?
      render :json => { :status => :error,
                        :message => 'Request must contain external_reference_id'\
                          ' and context_id.'}
      return
    end

    unless Context.exists?(context_id)
      render :json => { :status => :error,
                        :message => "Context_id is not valid."}
      return
    end

    unless current_user.has_role? :user, Context.find(context_id)
      render :json => { :status => :error,
                        :message => 'Current user doesnt have access to this'\
                          ' context.'}
      return
    end

    escal_count = 0
    escals_created = true
    EscalationLevel.where(context_id: context_id).each do |level|
      Subscription.where(escalation_level_id: level.id).each do |sub|
        #check if there exists scheduled escalation with same context_id &
        #external_id
        if ScheduledEscalation.where(subscription_id: sub.id).
          where(external_reference_id: external_id).
          where(status: 'scheduled').exists?
          escals_created = false
        else
          duedate = DateTime.now + level.when.minutes
          if ScheduledEscalation.create(subscription_id: sub.id,
                                        duedate: duedate,
                                        external_reference_id: external_id,
                                        status: 'scheduled')
            escal_count += 1
          end
        end
      end
    end

    if escals_created
      render :json => { :status => :ok,
                        :message => "#{escal_count} escalations created." }
    else
      render :json => { :status => :error,
                        :message => 'Escalations with same context_id and'\
                          ' external_reference_id are already scheduled.'}
    end
  end

  # DELETE /escalations
  def destroy
    external_id = params[:external_reference_id]
    context_id = params[:context_id]

    if external_id.nil? or context_id.nil?
      render :json => { :status => :error,
                        :message => 'Request must contain external_reference_id'\
                          ' and context_id.'}
      return
    end

    unless Context.exists?(context_id)
      render :json => { :status => :error,
                        :message => "Context_id is not valid."}
      return
    end

    unless current_user.has_role? :user, Context.find(context_id)
      render :json => { :status => :error,
                        :message => 'Current user doesnt have access to this'\
                          ' context.'}
      return
    end

    unless ScheduledEscalation.where(external_reference_id: external_id).exists?
      render :json => { :status => :error,
                        :message => "Escalations with that external_reference_id"\
                          " don't exist." }
      return
    end
    
    escal_count = 0
    EscalationLevel.where(context_id: context_id).each do |level|
      Subscription.where(escalation_level_id: level.id).each do |sub|
        ScheduledEscalation.where(external_reference_id: external_id).
          where(status: 'scheduled').each do |escal|
          escal_count += 1
          escal.status = 'canceled'
          escal.save
        end
      end
    end

    if escal_count == 0
      render :json => { :status => :error,
                        :message => 'Escalations with same context_id and'\
                          ' external_reference_id are already canceled.'}
    else
      render :json => { :status => :ok,
                        :message => "#{escal_count} escalations canceled." }
    end
  end
end

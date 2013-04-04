class Ability
  include CanCan::Ability

  def initialize(user)
    if user
        can :access, :rails_admin
      if user.has_role? :admin
        can :dashboard
        can :manage, :all

        cannot [:update, :create], ScheduledEscalation
      end
    end
  end
end

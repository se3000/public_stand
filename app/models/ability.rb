class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.persisted?
      can :manage, Campaign
      can :manage, Organization
    else
      can :read, Campaign
      can :read, Organization
    end
  end
end

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.persisted?
      can :manage, Campaign, organization_id: user.organization_ids
      can :manage, Organization, id: user.organization_ids
    end
    can :read, Campaign
    can :read, Organization
  end
end

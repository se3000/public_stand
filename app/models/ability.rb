class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.persisted?
      can :create, Campaign
      can :manage, Campaign, organization_id: user.organization_ids

      can :create, Organization
      can :manage, Organization, id: user.organization_ids
    end
    can :read, Campaign
    can :read, Organization
  end
end

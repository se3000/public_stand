class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.persisted?
      can :create, Campaign
      can :manage, Campaign, organization_id: user.organization_ids

      can :create, Organization
      can :manage, Organization, id: user.organization_ids

      can :edit, Picture, campaign_id: user.organizations.map(&:campaign_ids).flatten
      can :s3_update, Picture, campaign_id: user.organizations.map(&:campaign_ids).flatten
    end
    can :read, Campaign
    can :read, Organization
  end
end

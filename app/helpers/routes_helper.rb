module RoutesHelper
  def edit_organization_vanity(organization)
    vanity_edit_organization_url(subdomain: organization.vanity_string)
  end

  def campaign_vanity(campaign)
    vanity_organization_campaign_url(
      campaign_vanity: campaign.vanity_string,
      subdomain: campaign.organization.vanity_string
    )
  end

  def new_campaign_vanity(organization)
    vanity_new_organization_campaign_url(
      subdomain: organization.vanity_string
    )
  end

  def edit_campaign_vanity(campaign)
    vanity_edit_organization_campaign_url(
      campaign_vanity: campaign.vanity_string,
      subdomain: campaign.organization.vanity_string
    )
  end

  def edit_picture_vanity(picture)
    edit_picture_url(picture,
     subdomain: picture.campaign.organization.vanity_string)
  end
end

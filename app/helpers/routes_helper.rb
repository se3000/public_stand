module RoutesHelper

  def vanity_options(organization, options = {})
    options.merge({
      subdomain: subdomain(organization),
      host: host(organization),
      port: (ENV['PORT'])
    })
  end

  def edit_organization_vanity(organization)
    vanity_edit_organization_url(vanity_options(organization))
  end

  def campaign_vanity(campaign)
    vanity_organization_campaign_url(
      vanity_options(campaign.organization,
        campaign_vanity: campaign.vanity_string)
    )
  end

  def new_campaign_vanity(organization)
    vanity_new_organization_campaign_url(vanity_options(organization))
  end

  def edit_campaign_vanity(campaign)
    vanity_edit_organization_campaign_url(
      vanity_options(campaign.organization,
        campaign_vanity: campaign.vanity_string)
    )
  end

  def edit_picture_vanity(picture)
    edit_picture_url(picture, subdomain: picture.campaign.organization.vanity_string)
  end

  def host(organization)
    return local_base_url unless organization.host_url.present?
    logged_in? ? local_base_url : organization.host_url
  end

  def subdomain(organization)
    return organization.vanity_string unless organization.host_url.present?
    logged_in? ? organization.vanity_string : organization.host_url.match(/(.*?)\./)[1]
  end

  def organization_vanity(organization)
    vanity_organization_url(vanity_options(organization))
  end

  def campaign_vanity(campaign)
    vanity_organization_campaign_url(
      vanity_options(campaign.organization,
      campaign_vanity: campaign.vanity_string)
    )
  end

  def local_base_url
    ENV['HOST_BASE']
  end
end

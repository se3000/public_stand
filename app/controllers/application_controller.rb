class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :sanitize_for_cancan

  helper_method :current_user, :logged_in?, :organization_vanity, :campaign_vanity

  private

  def ensure_authenticated
    unless logged_in?
      flash.alert = "You must be logged in to access this page"
      redirect_to login_url
    end
  end

  def current_user
    @current_user ||= current_auth.user if current_auth
  end

  def current_auth
    @current_auth ||= Authentication.find_by_id(session[:authentication_id])
  end

  def logged_in?
    current_auth.present?
  end

  def sanitize_for_cancan #https://github.com/ryanb/cancan/issues/835#issuecomment-18663815
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  def organization_vanity(organization)
    root_url(subdomain: organization.vanity_string)
  end

  def campaign_vanity(campaign)
    vanity_organization_campaign_url(
      campaign_vanity: campaign.vanity_string,
      subdomain: campaign.organization.vanity_string
    )
  end

end
